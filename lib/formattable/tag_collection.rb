require 'formattable'
module Formattable
  class TagCollection
    include Enumerable

    def [](key)
      if TagCollection.complex_key?(key)
        matches = TagCollection.complex_key_regexp.match key
        called_key = matches[1]
        parameter  = matches[2] || nil
        parameter ? tags["(#{called_key})"].call(parameter) : tags["(#{called_key})"].call;
      else
        tags[key]
      end
    end

    def initialize(tags_hash=nil)
      unless tags_hash.nil?
        tags_hash.each {|key, value| raise ArgumentError unless TagCollection.valid_tag?(key, value) }
        @tags = tags_hash
      end
    end

    def []=(key, value)
      raise ArgumentError unless TagCollection.valid_tag?(key, value)
      if TagCollection.complex_key?(key)
        called_key       = TagCollection.complex_key_regexp.match(key)[1]
        tags['('+called_key+')'] = value
      else
        tags[key] = value
      end
    end

    def merge(other_hash)
      other_hash.each do |key, value|
        raise ArgumentError unless TagCollection.valid_tag?(key, value)
      end
      tags.merge!(other_hash)
    end

    def include?(obj)
      tags.include?(obj)
    end

    def tags
      @tags ||= Hash.new
    end

    def each(&block)
      tags.each &block
    end

    private

    def TagCollection.simple_key_regexp
      @simple_key_regexp  ||= /[[:alpha:]]/
    end

    def TagCollection.complex_key_regexp
      @complex_key_regexp ||= /\((\w*)\s*([^()]*)\)/
    end

    def TagCollection.key_regexp
      @key_regexp ||= Regexp.new('\A(' + simple_key_regexp.to_s + '|' + complex_key_regexp.to_s + ')\z')
    end

    def TagCollection.valid_tag?(key, value)
      return false unless key.kind_of? String and key.match(key_regexp)
      if (value.kind_of? Array and value.count == 2)
        return true
      elsif value.kind_of? Proc and value.parameters.count<2
        return true
      end
    end

    def TagCollection.complex_key?(key)
      key.match(complex_key_regexp)
    end
  end
end
