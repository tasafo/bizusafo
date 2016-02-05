class AddRatingCacheToStories < ActiveRecord::Migration
  def change
    add_column :stories, :rating_counter, :integer, default: 0
  end
end
