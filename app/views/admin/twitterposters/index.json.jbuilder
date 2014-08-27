json.array!(@twitterposters) do |twitterposter|
  json.extract! twitterposter, :id, :twitter_id, :screen_name, :poster_id
  json.url twitterposter_url(twitterposter, format: :json)
end
