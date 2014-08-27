class ChangeToBigint < ActiveRecord::Migration
  def change
  	remove_column :contents, :user_id
  	remove_column :contents, :post_id

  	add_column :contents, :user_id, :bigint
  	add_column :contents, :post_id, :bigint
  end
end
