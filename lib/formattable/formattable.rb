require 'formattable'
module Formattable
  def self.included(klass)
    required_methods = [:content, :tags, :paragraph_begin, :paragraph_end,  :line_break]
    required_methods.each do |method|
      unless klass.new.respond_to? method
        raise "#{klass.name} doesn't have a #{method} method!"
      end
    end
  end

  def formatted_content
    format(content)
  end

  def formatted_paragraphs
    paragraphs.map do |paragraph|
      paragraph_begin + format(paragraph).gsub(/\n/,line_break) + paragraph_end
    end
  end

  def paragraphs
    content.gsub(/\r/,'') #Removing troublesome carriage returns
    .split(/\n{2,}/) #Splits the text on places where there's two or more newlines (we want to keep the single ones alone)
    .map { |p| p.gsub(/(^ +)|( +$)/,'') } #Removes trailing and leading spaces
  end

  private
  def format(string)
    tags.inject(string) do |text, tag|
      key = tag[0]
      open_tag = tag[1][0]
      close_tag = tag[1][1]
      text.gsub!(/(^|[^\\])(\$#{key})(.*?)\2/, "\\1#{open_tag}\\3#{close_tag}")
      text.gsub(/(^|[^\\])\$#{key}/, "\\1#{open_tag}")
    end.gsub(/\\\$/,"$")
  end
end
