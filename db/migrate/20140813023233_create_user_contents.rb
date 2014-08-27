class CreateUserContents < ActiveRecord::Migration
  def change
    create_table :user_contents do |t|
      t.references :user, index: true
      t.references :content, index: true

      t.timestamps
    end
  end
end
