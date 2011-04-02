require 'formattable'
class Post < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  validates :title, :content, :author, :presence => true
  act_as_formattable   'i' => ["<span class='italic'>",    "</span>"],
                       'b' => ["<span class='bold'>",      "</span>"],
                       'u' => ["<span class='underline'>", "</span>"],
                       'o' => ["<span class='overline'>",  "</span>"],
                       't' => ["<span class='line-through'>",  "</span>"],
                       :paragraph_begin => '<p>',
                       :paragraph_end   => '</p>',
                       :line_break      => '<br />',
                       '()'             => lambda { |style| ["<span class='#{style}'>", "</span>"] }
end
