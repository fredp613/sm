class Artist < ActiveRecord::Base
	has_many :twitterposters
	has_many :instagramposters	
	has_many :contents
	has_many :user_artists

	
end
