class AddEditsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :edits, :integer, :default => 0
  end
end
