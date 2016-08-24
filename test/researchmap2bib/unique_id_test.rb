# coding: utf-8
require 'test_helper'
require 'researchmap2bib/unique_id'

class Researchmap2bibTest < Minitest::Test
  def setup
    @s = Class.new do
      extend ::Researchmap2bib::UniqueId
    end
  end

  def test_unique_id
    assert_equal 'key', @s.unique_id('key')
    assert_equal 'key:2', @s.unique_id('key')
    assert_equal 'key:3', @s.unique_id('key')
  end
end
