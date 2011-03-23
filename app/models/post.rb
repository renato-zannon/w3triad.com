class Post < ActiveRecord::Base
  validates :title, :content, :presence => true

  def paragraphs
    content.split(/\n{2,}/). #Separates the text on places where there are more two or more newlines (we want to keep the single ones alone)
      map { |p| p.gsub(/(^ +)|( +$)/,'') } #Removes trailing and leading spaces
  end
end
