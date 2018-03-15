class AddUrlUniqueIndexToStories < ActiveRecord::Migration
  def change
    add_index :stories, :url, unique: true
  end
end
