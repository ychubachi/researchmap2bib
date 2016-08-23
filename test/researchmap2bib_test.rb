# coding: utf-8
require 'test_helper'
require 'researchmap2bib'

class Researchmap2bibTest < Minitest::Test
  def setup
    @s = Researchmap2bib::ResearchmapReader.new
  end
  
  def test_that_it_has_a_version_number
    refute_nil ::Researchmap2bib::VERSION
  end

  def test_read_researchmap
    assert_nil = @s.read_researchmap('test/ychubachi.zip')
    assert_raises(Zip::Error) {
      @s.read_researchmap('test/nosuchfile.zip')
    }
  end

  def test_read_paper
    r = File.open('test/ychubachi/paper.xml') do |file|
      xml = file.read
      @s.read_paper(xml)
    end
    assert_equal 72, r.count
    assert_instance_of Researchmap2bib::Entry, r[0]
  end

  def test_read_entry
    doc = REXML::Document.new(<<XML)
<entry xmlns:rm="http://api.researchmap.jp/ns/" rm:type="paper" rm:disclose="public">
  <title>Title</title>
  <author><name>Name</name></author>
  <summary>Summary</summary>
  <rm:journal>Journal</rm:journal>
  <rm:publisher>Publisher</rm:publisher>
  <rm:publicationName>PublicationName</rm:publicationName>
  <rm:volume>31</rm:volume>
  <rm:number/>
  <rm:startingPage>121</rm:startingPage>
  <rm:endingPage>125</rm:endingPage>
  <rm:publicationDate>20140900</rm:publicationDate>
  <rm:language>ja</rm:language>
  <rm:paperType><id>0</id><name/></rm:paperType>
</entry>
XML
    entry = doc.elements["entry"]
    r = @s.read_entry(entry)
    assert_equal "#<struct Researchmap2bib::Entry title=\"Title\", author=\"Name\", summary=\"Summary\", journal=\"Journal\", publisher=\"Publisher\", publicationName=\"PublicationName\", volume=\"31\", number=nil, startingPage=\"121\", endingPage=\"125\", publicationDate=\"20140900\", referee=false, language=\"ja\", paperType=\"0\">", r.to_s
  end

  def test_write_bibliography_entry
    e = Researchmap2bib::Entry.new('Title', 'Author Name1, Author Name2')
    e.publicationDate="20140900"
    @s.write_bibliography_entry(e)
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

  def test_generate_key
    assert_equal 'Smith1608', @s.generate_key('John Smith, Kathy River', '20160800')
    assert_equal 'Smith16', @s.generate_key('John Smith, Kathy River', '20160000')
    assert_equal '山田1608', @s.generate_key('山田 太郎, 田中 花子', '20160800')
  end
end
