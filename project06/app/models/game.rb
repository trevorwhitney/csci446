class Game < ActiveRecord::Base
  belongs_to :rating
  belongs_to :user

  validates_presence_of :title

  before_create :set_user

  private

  def set_user
    self.user = UserSession.find.user
  end

end
