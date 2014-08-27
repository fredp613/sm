class ChagneTextToLongText < ActiveRecord::Migration
  def change
  	change_column :contents, :text, :text
  end
end
