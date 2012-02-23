class TwitterScheduledWorker
  extend Resque::Plugins::Retry

  @queue = :twitter_scheduled

  @retry_limit = 5


  def self.perform
    begin
      Newscloud::Tweeter.new.tweet_hot_items
    rescue Newscloud::TweeterDisabled => e
      Rails.logger.info("ERROR:: TwitterScheduledWorker failed with: #{e.inspect}")
    end
  end

end
