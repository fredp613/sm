class AddProfileImageUrlTwitterposters < ActiveRecord::Migration
  def change
  	add_column :twitterposters, :profile_image_url, :string
  end
end
