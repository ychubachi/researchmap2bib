# coding: utf-8
module Researchmap2bib
  module Utils
    def to_hankaku(str)
      str.tr('０-９ａ-ｚＡ-Ｚ，、　', '0-9a-zA-Z,, ')
    end
  end
end
