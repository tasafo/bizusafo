class AddUrlUniqueIndexToStories < ActiveRecord::Migration[4.2]
  def change
    add_index :stories, :url, unique: true
  end
end
