class RenameTwitColumn < ActiveRecord::Migration
  def change
  	rename_column :twitterposters, :twitter_id, :user_id
  end
end
