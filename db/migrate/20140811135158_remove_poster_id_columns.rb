class RemovePosterIdColumns < ActiveRecord::Migration
  def change
  	remove_column :twitterposters, :poster_id
  	remove_column :instagramposters, :poster_id
  end
end
