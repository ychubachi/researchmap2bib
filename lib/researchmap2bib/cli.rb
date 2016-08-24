# coding: utf-8
require 'thor'

module Researchmap2bib
  class CLI < Thor
    desc "generate ZIP_FILE", "researchmapの業績からbibliographyを作成"
    def generate(file_name)
      @s = Researchmap2bib::Generator.new
      @s.generate(file_name)
    end

    desc "version", "バージョンを表示"
    def version
      puts "researchmap2bib version #{::Researchmap2bib::VERSION}"
    end
  end
end
