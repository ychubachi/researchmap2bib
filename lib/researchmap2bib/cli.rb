# coding: utf-8
require 'thor'

module Researchmap2bib
  class CLI < Thor
    option 'newline', :type => :boolean
    desc "generate ZIP_FILE", "researchmapの業績からbibliographyを作成"
    def generate(file_name)
      @s = Researchmap2bib::Generator.new
      entries = @s.read_researchmap(file_name)

      results = Array.new
      entries.each do |entry|
        results.push(@s.make_bibliography_entry(entry))
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
