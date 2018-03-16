class ChangeDescriptionFieldFromStories < ActiveRecord::Migration[4.2]
  def change
    change_column :stories, :description,  :text
  end
end
