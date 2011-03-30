require 'formattable'
module Formattable
  class TagCollection
    include Enumerable

    def [](key)
      if TagCollection.complex_key?(key)
        tags['()'].call (key.gsub(/\A\(([\w\s]*)\)\z/, '\1'))
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
      tags[key] = value
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

    def TagCollection.valid_tag?(key, value)
      @key_regex ||= %r{\A([[:alpha:]]|\(\))\z}
      return false unless key.kind_of? String and key.match(@key_regex)
      if (value.kind_of? Array and value.count == 2)
        return true
      elsif value.kind_of? Proc and value.parameters.count==1
        return true
      end
    end

    def TagCollection.complex_key?(key)
      return true if key.match(/\([\w\s]*\)/)
    end
  end
end
