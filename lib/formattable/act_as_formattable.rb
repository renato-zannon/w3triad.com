require 'formattable'
module Formattable
  module ClassMethods
    def act_as_formattable(hash={})
      paragraph_begin = hash.delete(:paragraph_begin) || ''
      paragraph_end   = hash.delete(:paragraph_end)   || ''
      define_method(:paragraph_begin) { paragraph_begin }
      define_method(:paragraph_end)   { paragraph_end   }
      @@tags = Formattable::TagCollection.new(hash)
      define_method(:tags) { @@tags }
      class_eval do include Formattable end
    end
  end
end
