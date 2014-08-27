class CreateTwitterposters < ActiveRecord::Migration
  def change
    create_table :twitterposters do |t|
      t.integer :twitter_id
      t.string :screen_name
      t.references :poster, index: true

      t.timestamps
    end
  end
end
