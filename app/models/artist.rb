class Artist < ActiveRecord::Base
	has_many :twitterposters
	has_many :instagramposters	
	has_many :contents
	has_many :user_artists

	accepts_nested_attributes_for :twitterposters
	accepts_nested_attributes_for :instagramposters
	
end
