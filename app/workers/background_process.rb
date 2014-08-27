class BackgroundProcess < ActiveRecord::Base

  @queue = :jobs_queue

   def self.perform
    Content.pull_tweets
    Content.pull_instagram
  end
end