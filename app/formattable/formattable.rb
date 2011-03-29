module Formattable

  def tags
    @tags ||= TagCollection.new
  end

  def self.included(klass)
    unless klass.new.respond_to?(:content)
      raise "#{klass.name} doesn't have a content method!"
    end
  end

  def formatted_content
    tags.inject(content) do |text, tag|
      key = tag[0]
      open_tag = tag[1][0]
      close_tag = tag[1][1]
      text.gsub!(/(^|[^\\])(\$#{key})(.*?)\2/, "\\1#{open_tag}\\3#{close_tag}")
      text.gsub(/(^|[^\\])\$#{key}/, "\\1#{open_tag}")
    end.gsub(/\\\$/,"$")
  end
end
