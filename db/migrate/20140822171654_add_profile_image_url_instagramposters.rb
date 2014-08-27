class AddProfileImageUrlInstagramposters < ActiveRecord::Migration
  def change
  	add_column :instagramposters, :profile_image_url, :string
  end
end
