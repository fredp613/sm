class ConverntIntFields < ActiveRecord::Migration
  def change
  	remove_column :contents, :post_id
  	remove_column :contents, :user_id
  	add_column :contents, :post_id, :integer
  	add_column :contents, :user_id, :integer
  end
end
