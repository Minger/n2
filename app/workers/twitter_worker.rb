class TwitterWorker
  extend Resque::Plugins::Retry

  @queue = :twitter

  @retry_limit = 5

  def self.perform(klass, id)
    item = klass.constantize.find(id)
    return false unless item

    tweeter = Newscloud::Tweeter.new
    tweeter.tweet_item item
  end
end
