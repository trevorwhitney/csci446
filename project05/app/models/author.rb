class Author < ActiveRecord::Base
  has_many :articles
  has_attached_file :photo, styles: { small: "300x300>" },
  					url: "authors/:id/:style/:basename.:extension",
  					path: ":rails_root/public/assets/authors/:id/:style/:basename.:extension"

  validates :name, :presence => true
  validate :name_cannot_be_pat

  validates_attachment_presence :photo
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  def name_cannot_be_pat
    if name =~ /[P|p]at/
      errors.add(:name, 'cannot include "Pat". She broke my heart :(')
    end
  end
end
