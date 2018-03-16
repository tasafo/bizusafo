class CreateComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.references :author, index: true
      t.text :text
      t.references :commentable, :polymorphic => true

      t.timestamps null: false
    end

    add_index :comments, [:commentable_type, :commentable_id]
  end
end
