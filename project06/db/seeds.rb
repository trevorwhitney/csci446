# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.transaction do
  Role.create(:name => "Administrator", 
    :description => "An administrator can create, edit, and delete both users and roles.")
  Role.create(:name => "Member",
    :description => "A member can enter and rate games, but has no access to users and roles.")
end

User.transaction do
  admin = User.new do |u|
    u.first_name = "Joe"
    u.last_name = "Admin"
    u.password = "password"
    u.password_confirmation = "password"
    u.username = "administrator"
    u.email = "JoeAdmin@gamez.com"
    u.role_ids = [1]
    u.photo = File.new("db/seeds/bode-miller.jpg")
  end

  member = User.new do |u|
    u.first_name = "Joe"
    u.last_name = "Member"
    u.password = "password"
    u.password_confirmation = "password"
    u.username = "member"
    u.email = "JoeMember@gamez.com"
    u.role_ids = [2]
    u.photo = File.new("db/seeds/julia-mancuso.jpg")
  end

  admin.save
  member.save
end

Rating.transaction do
  %w{Amazing Good Meh Horrible}.each do |rating|
    Rating.create(:title => rating)
  end
end

Game.transaction do
  (1..100).each do |i|
    rating = Rating.find((i%4) + 1)
    user = User.find((i%2) + 1)
    Game.create(:title => "Finaly Fantasy #{i}", :rating => rating, 
      :user => user)
  end
end