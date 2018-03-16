class AddUserReferenceToStories < ActiveRecord::Migration[4.2]
  def change
    add_reference :stories, :user, index: true
  end
end
