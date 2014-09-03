class AddStateToContent < ActiveRecord::Migration
  def change
  	add_column :contents, :deleted, :boolean
  end
end
