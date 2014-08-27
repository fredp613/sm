class CreateInstagramposters < ActiveRecord::Migration
  def change
    create_table :instagramposters do |t|
      t.integer :ig_id
      t.string :screen_name
      t.references :poster, index: true

      t.timestamps
    end
  end
end
