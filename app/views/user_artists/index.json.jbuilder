json.array!(@user_artists) do |user_artist|
  json.extract! user_artist, :id, :user_id, :artist_id
  json.url user_artist_url(user_artist, format: :json)
end
