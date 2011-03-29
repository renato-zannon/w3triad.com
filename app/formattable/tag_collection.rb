module Formattable
  class TagCollection
    include Enumerable

    def [](key)
      tags[key]
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
      @key_regex ||= %r{\A([[:alpha:]]|\(\w+\))\z}
      return false unless key.kind_of? String and key.match(@key_regex)
      return false unless value.kind_of? Array and value.count == 2
      true
    end
  end
end
