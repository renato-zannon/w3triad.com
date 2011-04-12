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
      paragraph_begin + format(paragraph).gsub(/\n/,line_break+"\n") + paragraph_end
    end
  end

  def paragraphs
    content.gsub(/\r/,'') #Removing troublesome carriage returns
    .split(/\n{2,}/) #Splits the text on places where there's two or more newlines (we want to keep the single ones alone)
    .map { |p| p.gsub(/(^ +)|( +$)/,'') } #Removes trailing and leading spaces
  end

  private
  def format(string)
    simple_tags = tags.reject { |tag, _| tag.match(/\(.+\)/) }
    string = simple_format(string, simple_tags)
    string = complex_format(string)
    unescape_tags(string)
  end

  def simple_format(string, simple_tags)
    simple_tags.inject(string) do |text, tag|
      key = tag[0]
      open_tag = tag[1][0]
      close_tag = tag[1][1]
      text.gsub!(/(^|[^\\])(##{key})(.*?)\2/, "\\1#{open_tag}\\3#{close_tag}")
      text.gsub(/(^|[^\\])##{key}/, "\\1#{open_tag}")
    end
  end

  def complex_format(string)
    result = string.dup
    string.scan(/(?<!\\)#(\(\w+\s*[^)]*\))(.*?)((?<!\\)#\1)/) do |key, text, end_tag|
      next unless tags.include? key
      open_tag = tags[key][0]
      close_tag = (end_tag ? tags[key][1] : "")
      result.gsub!($&, open_tag+text+close_tag)
    end
    result
  end

  def unescape_tags(string)
    string.gsub('\#', '#')
  end
end
