# coding: utf-8
require "researchmap2bib/version"

require 'zip'
require 'rexml/document'
require 'rexml/parsers/ultralightparser'
require 'pp'

module Researchmap2bib
  Entry = Struct.new(
    :title, :author, :summary, :journal, :publisher, :publicationName,
    :volume, :number, :startingPage, :endingPage, :publicationDate,
    :referee, :language, :paperType,
  )
  
  Article = Struct.new(
    :author, :title, :journal, :year,
    :pages, :month, :note, :key,
    :volume, :number,
  )
  
  InProceedings = Struct.new(
    :author, :title, :booktitle, :year,
    :pages, :month, :note, :key,
    :editor, :organization,
    :publisher, :address,
  )

  class ResearchmapReader
    def read_researchmap(file_name)
      Zip::File.open(file_name) do |zip_file|
        entry = zip_file.glob('*\/paper.xml').first
        read_paper(entry.get_input_stream.read)
      end
    end

    def read_paper(xml)
      doc = REXML::Document.new(xml)
      entries = REXML::XPath.each(doc, '/feed/entry') do |entry|
        read_entry(entry)
      end
    end

    def read_entry(entry)
      title           = entry.elements["title"].text
      author          = entry.elements["author"].elements["name"].text
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
      paperType       = entry.elements["rm:paperType"].text
        
      Entry.new(
        title, author, summary, journal, publisher, publicationName,
        volume, number, startingPage, endingPage, publicationDate,
        referee, language, paperType,
      )
    end
  end
end
