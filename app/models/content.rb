class Content < ActiveRecord::Base
  # deprecated: :user_id, :user_name,
	# attr_accessible  :post_id, :image, :text, :instagramposter_id, :twitterposter_id
  belongs_to :instagramposter
  belongs_to :twitterposter
  belongs_to :artist
  has_many :deleted_contents
  
  default_scope  -> { order 'created_at DESC' }
  
  require 'twitter'
  require 'instagram'

  mount_uploader :image, ImageUploader
  attr_accessor :remove_image
  
  def self.instagram_content
    where(:twitterposter_id => nil)
  end

  def self.twitter_content
    where(:instagramposter_id => nil)
  end

  def self.run_job
    Resque..enqueue_in(5.seconds, BackgroundProcess)    
  end


  def social_media_site
    if self.twitterposter_id.nil?
       "Instagram"
    else
      "Twitter"
    end
  end

  def self.search(val)    
   c1 = self.joins(:twitterposter).where("text ILIKE ? OR twitterposters.screen_name ILIKE ?",
    "%#{val}%", "%#{val}%") 

   c2 = self.joins(:instagramposter).where("text ILIKE ? OR instagramposters.screen_name ILIKE ?",
    "%#{val}%", "%#{val}%") 
   c1 + c2
   
   
  end


	def self.pull_tweets

   #optimize this to only get since_id - see twitter docs - also add instagram to this somewhere
	 twitter_client = start_twitter
   poster = Twitterposter.all
    
    poster.each do |p|
      twitter_client.user_timeline(p.screen_name, count: 3200).each do |tweet|
         unless exists?(post_id: tweet.id) 
          tweet.media.each do |media|
            unless media.display_url.blank?                              
            create(
              # user_id: tweet.user.id,
              # user_name: tweet.user.screen_name,
              post_id: tweet.id,
              remote_image_url:media.media_url.to_s,
              text:tweet.text.gsub('\\', ''),              
              twitterposter_id: p.id,
              artist_id: p.artist.id,              
              created_at: tweet.created_at
            )
            end
          end
        end
      end
    end
  end

  def self.pull_instagram
    
    instagram_client = start_instagram

    poster = Instagramposter.all

    poster.each do |p|
      instagram_client.user_recent_media(p.ig_id.to_s, count: 200).each_with_index do |ig, i|
         unless exists?(post_id: ig.id.slice(0..(ig.id.index('_').to_i-1)))   
         
         media_text = ig.caption.to_s.split('text="').last.to_s
         media_text_final = media_text.slice(0..(media_text.index('>').to_i-2)).gsub('\\', '')                    
        
            create(
              # user_id: ig.user.id,
              # user_name: ig.user.username,
              post_id: ig.id.slice(0..(ig.id.index('_').to_i-1)),
              remote_image_url:ig.images.standard_resolution.url.to_s,
              text:media_text_final,
              instagramposter_id: p.id,
              artist_id: p.artist.id,
              created_at: Time.at(ig.created_time.to_i)
            )            
          end
        end
      end
   end


   # you need to test this
  def self.check_for_deleted
    #run a query that verifies existing twitter_post_id and instagram_post_id to dataset
    instagram_client = start_instagram
    poster = Instagramposter.all
    content_last_date = Content.instagram_content.order(:created_at).first.created_at
    scoped_contents = Content.instagram_content.where('created_at < ?', content_last_date)
    scoped_ig_post_ids = Array.new
    deleted_content = Array.new

    poster.each do |p|
      #might have to supply count argument here
      instagram_client.user_recent_media(p.ig_id.to_s, count: 200).each_with_index do |ig, i|
        
        if (ig.created_time.to_i < content_last_date.to_i) 
          scoped_ig_post_ids.push(ig.id.slice(0..(ig.id.index('_').to_i-1)))        
        end
      end
    end

    # deleted_content = scoped_contents.map(&:post_id).to_a scoped_ig_post_ids
    deleted_content = scoped_contents.map(&:post_id).reject { |a| a = scoped_ig_post_ids }

    return deleted_content
    # deleted_content.each do |dc|
    #   c = Content.where(post_id: dc).first
    #   c.deleted = true
    #   c.save!
    # end 
  end

  
  def self.ig_fetch_profile_images
    instagram_client = start_instagram
    poster = Instagramposter.all

    poster.each do |p|
      #might try user search here instead
      profile_image = instagram_client.user_recent_media(p.ig_id.to_s, count: 1).first.user.profile_picture

      if profile_image != p.profile_image
        po = Instagramposter.where(ig_id: p.ig_id).first
        po.remote_profile_image_url = profile_image
        po.save!
      end
    end
  end


  #you need to test this
  def self.twitter_fetch_profile_images
    twitter_client = start_twitter
    poster = Twitterposter.all

    poster.each do |p|
      #might try user search here instead
      profile_image = twitter_client.user(p.user_id).profile_image_url

      if profile_image != p.profile_image
        po = Twitterposter.where(user_id: p.user_id).first
        po.remote_profile_image_url = profile_image
        po.save!
      end
    end
  end 

  def self.start_instagram

    Instagram.configure do |config|
      config.client_id = ENV["instagram_api_key"]#Rails.application.secrets.instagram_api_key
      config.access_token = ENV["instagram_api_secret"]#Rails.application.secrets.instagram_api_secret
    end 
    @instagram_client = Instagram.client(:access_token => ENV["instagram_api_token"]  )#Rails.application.secrets.instagram_api_token)
  end

      

  def self.start_twitter
    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV["twitter_api_key"] #Rails.application.secrets.twitter_api_key
      config.consumer_secret = ENV["twitter_api_secret"] #Rails.application.secrets.twitter_api_secret
      oauth_token = ENV["twitter_api_token"] #Rails.application.secrets.twitter_api_token
      oauth_token_secret = ENV["twitter_api_token_secret"] #Rails.application.secrets.twitter_api_token_secret
    end
  end

  def following(user)
    if UserArtist.where(:user_id=>user).where(:artist_id=>self.artist_id).blank?
      return false
    else
      return true
    end
  end

   def favorite(user)
    if UserContent.where(:user_id=>user).where(:content_id=>self.id).blank?
      return false
    else
      return true
    end
  end

  def favorite_item(content_id, user_id)
     UserContent.where(:user_id=>user_id).where(:content_id=>content_id).first.id
  end

  def self.favorites(user)
    user_favorites = UserContent.where(user_id: user)
    self.where(id: user_favorites.select(:content_id))
  end
  

  def self.artists(user)
    user_artists = UserArtist.where(user_id: user)
    self.where(artist_id: user_artists.select(:artist_id))
  end

  def self.by_artist(artist)
    self.where(artist_id: artist)
  end


  def user_name
    if self.twitterposter_id.nil?
       self.instagramposter.screen_name
    else
      self.twitterposter.screen_name
    end    
  end

  

end
