class AddUsersCountToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :users_count, :integer, :default => 0

    Role.reset_column_information
    Role.all.each do |r|
      r.update_attribute :users_count, r.users.length
    end
  end

  def self.down
    remove_column :roles, :users_count
  end
  
end
