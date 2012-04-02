class Members::GamesController < Members::MembersController
  before_filter :require_user

  def index
  end

end