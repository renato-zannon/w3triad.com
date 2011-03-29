module Formattable

  def tags
    @tags ||= {}
  end

  def self.included(klass)
    unless klass.new.respond_to?(:content)
      raise "#{klass.name} doesn't have a content method!"
    end
  end
end
