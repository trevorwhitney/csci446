class Game < ActiveRecord::Base
  belongs_to :rating
  belongs_to :user, :counter_cache => true

  validates_presence_of :title

  before_create :set_user

  def self.users_games(user, page)
    Game.where(:user_id => user.id).paginate :per_page => 10, 
    :page => page, :include => [:rating, :user], 
    :order => "created_at DESC"
  end

  def self.all_games(page)
    Game.paginate :per_page => 10, :page => page,
      :include => [:rating, :user], :order => "created_at DESC"
  end

  private

  def set_user
    if self.user.nil?
      self.user = UserSession.find.user
    end
  end

end
