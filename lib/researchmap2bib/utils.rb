# coding: utf-8
module Researchmap2bib
  module Utils
    def to_hankaku(str)
      str.tr('０-９ａ-ｚＡ-Ｚ，、　', '0-9a-zA-Z,, ')
    end

    def year_month(date)
      /([0-9]{4})([0-9]{2})/.match(date).captures
    end

    def concatenate_authors(authors)
      authors.gsub(/ *, */, ' and ')
    end

    def first_author(authors)
      r = /([^,]*)/.match(authors)
      r == nil ? authors.strip : r.captures[0].strip
    end

    def family_name(author)
      if /(^\w*) *(\w*)$/ =~ author
        $2
      elsif /(^\S*) *(\S*)$/ =~ author
        $1
      else
        author
      end
    end
  end
end
