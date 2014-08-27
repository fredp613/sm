class UserArtist < ActiveRecord::Base
  belongs_to :user
  belongs_to :artist

  def self.get_id_from_content(user, artist)
	where(user_id: user).where(artist_id: artist).first.id
  end

  def self.find_by_user_artist(user, artist)
	where(user_id: user).where(artist_id: artist).first
  end


  
end
