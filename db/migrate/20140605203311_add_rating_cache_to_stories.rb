class AddRatingCacheToStories < ActiveRecord::Migration[4.2]
  def change
    add_column :stories, :rating_counter, :integer, default: 0
  end
end
