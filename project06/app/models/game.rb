class Game < ActiveRecord::Base
  belongs_to :rating
  belongs_to :user

  validates_presence_of :title
end
