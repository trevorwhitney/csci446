class Article < ActiveRecord::Base
  belongs_to :author

  validates :title, :body, :author_id, :presence => true
  validates :title, :uniqueness => true
end
