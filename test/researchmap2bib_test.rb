# coding: utf-8
require 'test_helper'

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

  # def test_read_paper
  #   assert_nil @s.read_paper
  # end

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
    assert_equal "#<struct Researchmap2bib::Entry title=\"Title\", author=\"Name\", summary=\"Summary\", journal=\"Journal\", publisher=\"Publisher\", publicationName=\"PublicationName\", volume=\"31\", number=nil, startingPage=\"121\", endingPage=\"125\", publicationDate=\"20140900\", referee=false, language=\"ja\", paperType=nil>", r.to_s
  end
end
