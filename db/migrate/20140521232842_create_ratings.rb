class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true
      t.references :rateable, :polymorphic => true
      t.boolean :positive

      t.timestamps null: false
    end

    add_index :ratings, [:rateable_type, :rateable_id]
  end
end
