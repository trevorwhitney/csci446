require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "game must have title" do 
    game = Game.new
    assert !game.valid?

    game.title = "Skyrim"
    assert game.valid?
  end

  test "created_by" do
    login_member

    game = Game.new :title => "some game"

    game.save

    assert game.created_by?(users(:member))
  end

  test "new game user should be current_user" do
    login_member

    game = Game.new :title => "Awesome game"
    game.save

    assert_equal users(:member), game.user

    login_admin

    game = Game.new :title => "Terrible Game"
    game.save

    assert_equal users(:admin), game.user
  end

end
