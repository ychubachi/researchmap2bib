# coding: utf-8
require 'test_helper'
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

  def test_concatenate_authors
    assert_equal 'First Last', @s.concatenate_authors('First Last')
    assert_equal 'First1 Last1 and First2 Last2',
                 @s.concatenate_authors('First1 Last1, First2 Last2')
    assert_equal 'First1 Last1 and First2 Last2 and First3 Last3',
                 @s.concatenate_authors('First1 Last1, First2 Last2 , First3 Last3')
    assert_equal '山田 太郎 and 田中 花子',
                 @s.concatenate_authors('山田 太郎 ,田中 花子')
  end

  def test_first_author
    assert_equal 'John Smith', @s.first_author('John Smith')
    assert_equal 'John Smith', @s.first_author('John Smith , Kathy River')
    assert_equal '山田 太郎', @s.first_author('山田 太郎, 田中 花子')
    assert_equal '山田 太郎', @s.first_author('山田 太郎, 田中 花子, 斎藤 次郎')
  end

  def test_family_name
    assert_equal 'Smith', @s.family_name('John Smith')
    assert_equal '山田', @s.family_name('山田 太郎')
    assert_equal '山田太郎', @s.family_name('山田太郎')
  end
end
