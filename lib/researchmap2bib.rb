# coding: utf-8
require "researchmap2bib/version"
require 'researchmap2bib/utils'
require 'researchmap2bib/unique_id'
require 'researchmap2bib/cli'
require 'researchmap2bib/generator'

module Researchmap2bib
  Entry = Struct.new(
    :id,
    :title, :author, :summary, :journal, :publisher, :publicationName,
    :volume, :number, :startingPage, :endingPage, :publicationDate,
    :referee, :language, :paperType,
  )
end
