class AddEditsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :edits, :integer
  end
end
