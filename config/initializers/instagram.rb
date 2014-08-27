require "instagram"

Instagram.configure do |config|

	config.client_id = Rails.application.secrets.instagram_api_key	
	config.access_token = Rails.application.secrets.instagram_api_secret

end