# coding: utf-8
require 'test_helper'
require 'researchmap2bib'
require 'researchmap2bib/utils'

class Researchmap2bibTest < Minitest::Test
  def setup
    @s = Class.new do
      extend ::Researchmap2bib::Utils
    end
  end

  def test_to_hankaku
    assert_equal '1234', @s.to_hankaku('１２３４')
    assert_equal 'abc', @s.to_hankaku('ａｂｃ')
    assert_equal ',', @s.to_hankaku('，')
    assert_equal ',', @s.to_hankaku('、')
    assert_equal ' ', @s.to_hankaku('　')
  end
end
