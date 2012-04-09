class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.integer :rating_id, :default => 0

      t.timestamps
    end
  end
end
