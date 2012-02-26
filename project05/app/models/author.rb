class Author < ActiveRecord::Base
  has_many :articles

  validates :name, :presence => true
  validate :name_cannot_be_pat

  def name_cannot_be_pat
    if name =~ /[P|p]at/
      errors.add(:name, 'cannot include "Pat". She broke my heart :(')
    end
  end
end
