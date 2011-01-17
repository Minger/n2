# Load ActiveRecord Base Model Extensions
require "#{RAILS_ROOT}/lib/activerecord_model_extensions.rb"
ActiveRecord::Base.send :include, Newscloud::ActiverecordModelExtensions

# Load acts_as_featured_item mixin
require "#{RAILS_ROOT}/lib/acts_as_featured_item.rb"
ActiveRecord::Base.send :include, Newscloud::Acts::FeaturedItem

# Load acts_as_media_item mixin
require "#{RAILS_ROOT}/lib/acts_as_media_item.rb"
ActiveRecord::Base.send :include, Newscloud::Acts::MediaItem

# Load acts_as_moderatable mixin
require "#{RAILS_ROOT}/lib/acts_as_moderatable.rb"
ActiveRecord::Base.send :include, Newscloud::Acts::Moderatable

# Load acts_as_relatable mixin
require "#{RAILS_ROOT}/lib/acts_as_relatable.rb"
ActiveRecord::Base.send :include, Newscloud::Acts::Relatable
# Send acts_as_moderatable to plugin models
Tagging.send(:acts_as_moderatable)
Tag.send(:acts_as_moderatable)
PfeedItem.send(:acts_as_moderatable)
PfeedDelivery.send(:acts_as_moderatable)

# Load acts_as_refineable mixin
require "#{RAILS_ROOT}/lib/acts_as_refineable.rb"
ActiveRecord::Base.send :include, Newscloud::Acts::Refineable

# Load acts_as_wall_postable mixin
require "#{RAILS_ROOT}/lib/acts_as_wall_postable.rb"
ActiveRecord::Base.send :include, Newscloud::Acts::WallPostable

# Load acts_as_galleryable mixin
require "#{RAILS_ROOT}/lib/acts_as_galleryable.rb"
ActiveRecord::Base.send :include, Newscloud::Acts::Galleryable

# Load acts_as_tweetable mixin
require "#{RAILS_ROOT}/lib/acts_as_tweetable.rb"
ActiveRecord::Base.send :include, Newscloud::Acts::Tweetable

# Load acts_as_async_processable mixin
require "#{RAILS_ROOT}/lib/acts_as_async_processable.rb"
ActiveRecord::Base.send :include, Newscloud::Acts::AsyncProcessable

# Load acts_as_scorable mixin
require "#{RAILS_ROOT}/lib/acts_as_scorable.rb"
ActiveRecord::Base.send :include, Newscloud::Acts::Scorable
# HACK:: get around Vote model being a plugin model
Vote.send(:acts_as_scorable)

# Load plugin model extensions
require "#{RAILS_ROOT}/lib/locale_extensions.rb"
require "#{RAILS_ROOT}/lib/pfeed_extensions.rb"

require "#{RAILS_ROOT}/lib/zvent_gem_addon.rb"

require "#{RAILS_ROOT}/lib/string_extensions.rb"
require "#{RAILS_ROOT}/lib/feed_parser.rb"
require "#{RAILS_ROOT}/lib/tweeter.rb"