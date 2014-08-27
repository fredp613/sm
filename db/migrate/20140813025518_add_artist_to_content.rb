class AddArtistToContent < ActiveRecord::Migration
  def change
  	add_column :contents, :artist_id, :integer
  end
end
