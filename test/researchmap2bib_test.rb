# coding: utf-8
require 'test_helper'
require 'researchmap2bib'
require 'researchmap2bib/utils'
require 'researchmap2bib/unique_id'
require 'researchmap2bib/cli'
require 'researchmap2bib/generator'

class Researchmap2bibTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Researchmap2bib::VERSION
  end
end
