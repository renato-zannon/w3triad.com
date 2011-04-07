require 'formattable'
class Post < ActiveRecord::Base
  self.per_page = 5

  has_friendly_id :title, :use_slug => true, :strip_non_ascii => true

  belongs_to :author, :class_name => 'User'
  validates :title, :content, :author, :presence => true
  validates :title, :uniqueness => true

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
