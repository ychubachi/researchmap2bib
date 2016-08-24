# coding: utf-8
require "researchmap2bib/version"
require 'researchmap2bib/utils'
require 'researchmap2bib/unique_id'

require 'zip'
require 'rexml/document'
require 'pp'
require 'erb'
require 'thor'

module Researchmap2bib
  Entry = Struct.new(
    :id,
    :title, :author, :summary, :journal, :publisher, :publicationName,
    :volume, :number, :startingPage, :endingPage, :publicationDate,
    :referee, :language, :paperType,
  )

  class ResearchmapReader
    include Utils
    include UniqueId
    
    def read_researchmap(file_name)
      entries = Zip::File.open(file_name) do |zip_file|
        entry = zip_file.glob('*\/paper.xml').first
        read_paper(entry.get_input_stream.read)
      end
    end

    def read_paper(xml)
      doc = REXML::Document.new(xml)
      entries = Array.new
      REXML::XPath.each(doc, '/feed/entry') do |entry|
        entries.push(read_entry(entry))
      end
      entries
    end

    def read_entry(entry)
      title           = entry.elements["title"].text
      author          = entry.elements["author"].elements["name"].text
      author          = to_hankaku(author)
      summary         = entry.elements["summary"].text
      journal         = entry.elements["rm:journal"].text
      publisher       = entry.elements["rm:publisher"].text
      publicationName = entry.elements["rm:publicationName"].text
      volume          = entry.elements["rm:volume"].text
      number          = entry.elements["rm:number"].text
      startingPage    = entry.elements["rm:startingPage"].text
      endingPage      = entry.elements["rm:endingPage"].text
      publicationDate = entry.elements["rm:publicationDate"].text
      referee         = entry.elements["rm:referee"] ? true : false
      language        = entry.elements["rm:language"].text
      paperType       = entry.elements["rm:paperType"].elements["id"].text
        
      Entry.new(
        nil, # id
        title, author, summary, journal, publisher, publicationName,
        volume, number, startingPage, endingPage, publicationDate,
        referee, language, paperType,
      )
    end

#     0:未設定、1:研究論文(学術雑誌)、2:研究論文(国際会議プロシーディングス)、3:研究論文(大学,研究機関紀要)
# 、
# 4:研究論文(研究会,シンポジウム資料等)、5:研究論文(その他学術会議資料等)
    def write_bibliography_entry(entry)
      key = generate_key(entry.author, entry.publicationDate)
      id = unique_id(key)

      year, month = year_month(entry.publicationDate)
      month = month.to_i
      case entry.paperType.to_i
      when 1, 3 then
        record = <<EOS
@Article{<%= id %>,
  author = 	 {<%= entry.author %>},
  title = 	 {<%= entry.title %>},
  journal = 	 {<%= entry.journal %>},
EOS
        record += '  year      = <%= year %>'
        if month > 0
          record += ",\n  month     = <%= month %>"
        end
        if entry.volume
          record += ",\n  volume    = <%= entry.volume %>"
        end
        if entry.number
          record += ",\n  number    = <%= entry.number %>"
        end
        if entry.startingPage && entry.endingPage
          record += ",\n  pages     = <%= entry.startingPage %>-<%= entry.endingPage %>"
        elsif entry.startingPage
          record += ",\n  pages     = <%= entry.startingPage %> %>"
        end
        record += "}\n"
        if entry.summary
          record += "% <%= entry.summary %>\n"
        end
      else
        record = <<EOS
@InProceedings{<%= id %>,
  author    = {<%= entry.author %>},
  title     = {<%= entry.title %>},
  booktitle = {<%= entry.journal %>},
EOS
        record += '  year      = <%= year %>'
        if month > 0
          record += ",\n  month     = <%= month %>"
        end
        if entry.volume
          record += ",\n  volume    = <%= entry.volume %>"
        end
        if entry.number
          record += ",\n  number    = <%= entry.number %>"
        end
        if entry.startingPage && entry.endingPage
          record += ",\n  pages     = <%= entry.startingPage %>-<%= entry.endingPage %>"
        elsif entry.startingPage
          record += ",\n  pages     = <%= entry.startingPage %> %>"
        end
        if entry.publisher
          record += ",\n  publisher = {<%= entry.publisher %>}"
        end
        record += "}\n"
        if entry.summary
          record += "% <%= entry.summary %>\n"
        end
      end
      erb = ERB.new(record)
      erb.result(binding)
    end

    def generate_key(authors, date)
      first_author = first_author(authors)
      name = family_name(first_author)
      year, month = year_month(date)
      year = /[0-9][0-9]([0-9][0-9])/.match(year).captures[0]
      if month.to_i >0
        name + year + month
      else
        name + year
      end
    end
  end

  class CLI < Thor
    option 'newline', :type => :boolean
    desc "generate ZIP_FILE", "researchmapの業績からbibliographyを作成"
    def generate(file_name)
      @s = Researchmap2bib::ResearchmapReader.new
      entries = @s.read_researchmap(file_name)

      results = Array.new
      entries.each do |entry|
        results.push(@s.write_bibliography_entry(entry))
      end

      # entries.each do |entry|
      #   puts 

      puts options['newline'] == false ? results : results.join("\n")
    end

    desc "version", "バージョンを表示"
    def version
      puts "researchmap2bib version #{::Researchmap2bib::VERSION}"
    end
  end
end
