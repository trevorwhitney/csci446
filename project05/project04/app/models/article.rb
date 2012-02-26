class Article < ActiveRecord::Base
  belongs_to :author

  validates :title, :body, :author_id, :presence => true
  validates :title, :uniqueness => true

  before_save :increment_edits

  private

  def increment_edits
    self.edits += 1
  end
end
