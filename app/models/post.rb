require 'formattable'
class Post < ActiveRecord::Base
  validates :title, :content, :presence => true
  act_as_formattable   'i' => ["<span class='italic'>",    "</span>"],
                       'b' => ["<span class='bold'>",      "</span>"],
                       'u' => ["<span class='underline'>", "</span>"],
                       'o' => ["<span class='overline'>",  "</span>"],
                       't' => ["<span class='line-through'>",  "</span>"],
                       :paragraph_begin => '<p>',
                       :paragraph_end   => '</p>'
end
