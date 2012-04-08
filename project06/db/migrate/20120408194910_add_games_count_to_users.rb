class AddGamesCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :games_count, :integer, :default => 0

    User.reset_column_information
    User.all.each do |u|
      u.update_attribute :games_count, u.games.length
    end
  end

  def self.down
    remove_column :users, :games_count
  end

end
