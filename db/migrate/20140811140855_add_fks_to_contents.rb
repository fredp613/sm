class AddFksToContents < ActiveRecord::Migration
  def change
  	add_column :contents, :instagramposter_id, :integer
  	add_column :contents, :twitterposter_id, :integer
  end
end
