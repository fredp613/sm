class CreateDeletedContents < ActiveRecord::Migration
  def change
    create_table :deleted_contents do |t|
      t.references :content, index: true

      t.timestamps
    end
  end
end
