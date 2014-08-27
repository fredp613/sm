class AddArtistIdToTables < ActiveRecord::Migration
  def change
  	add_column :twitterposters, :artist_id, :integer
  	add_column :instagramposters, :artist_id, :integer
  end
end
