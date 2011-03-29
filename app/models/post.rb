class Post < ActiveRecord::Base
  include Formattable
  validates :title, :content, :presence => true

end
