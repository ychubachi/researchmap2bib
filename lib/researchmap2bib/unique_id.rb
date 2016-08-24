# coding: utf-8
module Researchmap2bib
  module UniqueId
    @@id_to_entry = Hash.new

    def unique_id(key)
      if @@id_to_entry[key]
        i = 2
        begin
          new_key = key + ':' + i.to_s
          i += 1
        end while @@id_to_entry[new_key]
        @@id_to_entry[new_key] = true
        return new_key
      else
        @@id_to_entry[key] = true
        return key
      end
    end
  end
end
