class RenameColumnsImages < ActiveRecord::Migration
  def change
  	rename_column :twitterposters, :profile_image_url, :profile_image
  	rename_column :instagramposters, :profile_image_url, :profile_image
  end
end
