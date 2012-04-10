require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new do |u|
      u.email = "new_email@email.com"
      u.username = "jsmith"
      u.first_name = "joe"
      u.last_name = "smith"
      u.password = "stones"
      u.password_confirmation = "stones"
    end
  end

  #test validations
  test "username must be 6 characters" do
    user = @user
    user.username = "joe"

    assert !user.valid?

    user.username = "joeseph"

    assert user.valid?
  end

  test "password must be 6 characters" do
    user = @user
    user.password = "stone"
    user.password_confirmation = "stone"

    assert !user.valid?

    user.password = "stones"
    user.password_confirmation = "stones"

    assert user.valid?
  end

  test "username must be unique" do
    user = @user
    user.username = users(:admin).username

    assert !user.valid?

    user.username = "newuser"

    assert user.valid?
  end

  test "email must be unique" do
    user = @user
    user.email = users(:admin).email

    assert !user.valid?

    user.email = "old_email@email.com"

    assert user.valid?
  end

  test "is_admin?" do
    assert users(:admin).is_admin?
    assert !users(:member).is_admin?
  end

  test "last_login" do
    user = users(:admin)

    #test minutes ago
    user.last_login_at = 2.minutes.ago
    assert_equal "Two minutes ago", user.last_login(Time.now)

    #test hours ago
    user.last_login_at = 3.hours.ago
    assert_equal "Three hours ago", user.last_login(Time.now)
    user.last_login_at = Time.now.yesterday
    assert_equal "Yesterday", user.last_login(Time.now)

    #test days
    user.last_login_at = Time.now.yesterday
    assert_equal "Yesterday", user.last_login(Time.now)
    user.last_login_at = 4.days.ago
    assert_equal "Four days ago", user.last_login(Time.now)

    #test weeks
    user.last_login_at = 1.weeks.ago
    assert_equal "One week ago", user.last_login(Time.now)

    #test months
    user.last_login_at = 5.months.ago
    assert_equal "Five months ago", user.last_login(Time.now)

    #test years
    user.last_login_at = 2.years.ago
    assert_equal "Over a year ago", user.last_login(Time.now)
  end

  test "full_name" do
    assert_equal "Joe Admin", users(:admin).full_name
    assert_equal "Joe Member", users(:member).full_name
  end

  test "role_symbols" do
    assert_equal [:administrator], users(:admin).role_symbols
    assert_equal [:member], users(:member).role_symbols

    users(:admin).roles << Role.find_by_name("Member")
    assert_equal [:administrator, :member], users(:admin).role_symbols
  end


  test "role_ids" do
    assert users(:admin).role_ids.include? roles(:administrator).id
    assert users(:member).role_ids.include? roles(:member).id
  end

  test "add role" do
    user = users(:member)
    user.role(roles(:administrator).id)

    assert_equal [roles(:administrator).id, roles(:member).id].sort, 
      user.role_ids.sort
  end

  test "games count" do
    admin = users(:admin)
    login_admin

    game = Game.new :title => "Monkey Pirates"
    game.save

    admin.reload

    assert_equal 2, admin.games.size
  end

  test "percent of games rated" do
    admin = users(:admin)
    assert_equal 100, admin.percent_of_games_rated

    login_admin

    game = Game.new( :title => "New Game")
    game.save

    admin.reload

    assert_equal 50, admin.percent_of_games_rated

    game.rating_id = 1
    game.save

    admin.reload

    assert_equal 100, admin.percent_of_games_rated
  end

end
