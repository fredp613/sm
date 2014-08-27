class UserContent < ActiveRecord::Base
  belongs_to :user
  belongs_to :content

  def self.get_id_from_favorite(content_id, user_id)
  	where(user_id: user_id).where(content_id: content_id).first.id
  end
end
