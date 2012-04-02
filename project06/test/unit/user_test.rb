require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    %w{Administrator Member}.each do |role|
      Role.create(:name => role)
    end

    @admin = users(:admin)
    @admin.password = "password"
    @admin.password_confirmation = "password"

    @member = users(:member)
    @member.password = "password"
    @member.password_confirmation = "password"

    @admin.save
    @member.save
  end

  test "is_admin?" do
    assert @admin.is_admin?
    assert !@member.is_admin?
  end


  test "last_login" do
    user = @admin

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
    assert_equal "Joe Admin", @admin.full_name
    assert_equal "Joe Member", @member.full_name
  end

  test "role_symbols" do
    assert_equal [:administrator], @admin.role_symbols
    assert_equal [:member], @member.role_symbols

    @admin.roles << Role.find_by_name("member")
    assert_equal [:administrator, :member], @admin.role_symbols
  end

end
