json.array!(@instagramposters) do |instagramposter|
  json.extract! instagramposter, :id, :ig_id, :screen_name, :poster_id
  json.url instagramposter_url(instagramposter, format: :json)
end
