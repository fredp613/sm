class Instagramposter < ActiveRecord::Base
	belongs_to :artist
	has_many :contents
	
	mount_uploader :profile_image, ProfileImageUploader
end
