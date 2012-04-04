require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "game must have title" do 
    game = Game.new
    assert !game.valid?

    game.title = "Skyrim"
    assert game.valid?
  end

end
