class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :user_id
      t.string :user_name
      t.string :post_id
      t.string :image
      t.string :text

      t.timestamps
    end
  end
end
