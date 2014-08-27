class ChangeCreatedAt < ActiveRecord::Migration
  def change
  	change_column :contents, :post_id, :bigint
  end
end
