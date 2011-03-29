class Post < ActiveRecord::Base
  include Formattable
  validates :title, :content, :presence => true

  def paragraphs
    content.gsub(/\r/,'') #Removing troublesome carriage returns
      .split(/\n{2,}/) #Splits the text on places where there's two or more newlines (we want to keep the single ones alone)
      .map { |p| p.gsub(/(^ +)|( +$)/,'') } #Removes trailing and leading spaces
  end
end
