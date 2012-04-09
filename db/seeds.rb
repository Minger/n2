# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# set debug flag
debug = Rails.env.development?

# Initial Topic Sections
IdeaBoard.create!({:name => 'General', :section =>'general',:description=>'General ideas.'}) unless IdeaBoard.find_by_name_and_section('General', 'general')
ResourceSection.create!({:name => 'General', :section =>'general',:description=>'General links.'}) unless ResourceSection.find_by_name_and_section('General', 'general')
if Forum.count == 0
  Forum.create!({:name => 'General', :description=>'Talk about whatever you want. This area is for open discussion.'}) unless Forum.find_by_name('General')
  Forum.create!({:name => 'Feedback', :description=>"Tell us how we're doing. Share your thoughts about #{APP_CONFIG['site_title']}!"}) unless Forum.find_by_name('Feedback')
end
# Initial Classified Categories
["Appliances", "Antiques and Collectibles", "Bikes", "Boats", "Books", "Business", "Computer", "Furniture", "General", "Jewelry", "Materials", "Sporting", "Tickets", "Tools", "Arts and Crafts", "Auto Parts", "Baby and Kids", "Beauty and Health", "Cars and Trucks", "Cds, Dvd, Vhs", "Cell Phones", "Clothes", "Electronics", "Garden", "Household", "Motorcycles", "Musical Instruments", "Photo and Video", "Toys", "Video Games", "Gaming"].each do |category|
  Classified.add_category(category) unless Classified.categories.find_by_name(category)
end

#TODO:: - fix (User.admins.last || nil) - creates fb user as nil, bombs out in fb helper for profilepic

# Default Prediction Group
#if PredictionGroup.count == 0
#  PredictionGroup.create!({:title => 'Other', :section => 'other', :description => 'This topic is for uncategorized questions'}) unless PredictionGroup.find_by_title_and_section('Other','other')
#end

# Populate Sources table with some commonly used sites
Source.create!({:name => 'New York Times', :url =>'nytimes.com'}) unless Source.find_by_url('nytimes.com')
Source.create!({:name => 'Los Angeles Times', :url =>'latimes.com'}) unless Source.find_by_url('latimes.com')
Source.create!({:name => 'Chicago Tribune', :url =>'chicagotribune.com'}) unless Source.find_by_url('chicagotribune.com')
Source.create!({:name => 'National Public Radio', :url =>'npr.org'}) unless Source.find_by_url('npr.org')

#######################################################################
# Default Topic Feeds
#######################################################################
[
	{
		:topic   => "Global News",
		:title   => "New York Times Top Stories Global",
		:rss_url => "http://www.nytimes.com/services/xml/rss/nyt/GlobalHome.xml"
	},
	{
		:topic   => "Global News",
		:title   => "Euraeka Top news",
		:rss_url => "http://euraeka.com/news.rss"
	},
	{
		:topic   => "Global News",
		:title   => "New York Times Magazine",
		:rss_url => "http://feeds.nytimes.com/nyt/rss/Magazine"
	},
	{
		:topic   => "Global News",
		:title   => "New York Times Week in Review",
		:rss_url => "http://feeds.nytimes.com/nyt/rss/WeekinReview"
	},
	{
		:topic   => "Global News",
		:title   => "Yahoo Top Stories",
		:rss_url => "http://rss.news.yahoo.com/rss/topstories"
	},
	{
		:topic   => "US News",
		:title   => "New York Times Top Stories U.S.",
		:rss_url => "http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml"
	},
	{
		:topic   => "Entertainment",
		:title   => "Euraeka Entertainment News",
		:rss_url => "http://euraeka.com/entertainment.rss"
	},
	{
		:topic   => "Entertainment",
		:title   => "Yahoo Entertainment",
		:rss_url => "http://rss.news.yahoo.com/rss/entertainment"
	},
	{
		:topic   => "Lifestyle",
		:title   => "Euraeka Lifestyle News",
		:rss_url => "http://euraeka.com/lifestyle.rss"
	},
	{
		:topic   => "Offbeat",
		:title   => "Yahoo Oddly Enough",
		:rss_url => "http://rss.news.yahoo.com/rss/oddlyenough"
	},
	{
		:topic   => "Offbeat",
		:title   => "Euraeka Offbeat News",
		:rss_url => "http://euraeka.com/offbeat.rss"
	},
	{
		:topic   => "Opinion",
		:title   => "New York Times Opinion",
		:rss_url => "http://feeds.nytimes.com/nyt/rss/Opinion"
	},
	{
		:topic   => "Opinion",
		:title   => "New York Times Op Ed Columnists",
		:rss_url => "http://topics.nytimes.com/top/opinion/editorialsandoped/oped/columnists/index.html?rss=1"
	},
	{
		:topic   => "Opinion",
		:title   => "Yahoo Opinion",
		:rss_url => "http://rss.news.yahoo.com/rss/oped"
	},
	{
		:topic   => "Politics",
		:title   => "Yahoo Politics",
		:rss_url => "http://rss.news.yahoo.com/rss/politics"
	},
	{
		:topic   => "Technology",
		:title   => "Yahoo Technology",
		:rss_url => "http://rss.news.yahoo.com/rss/tech"
	},
	{
		:topic   => "Technology",
		:title   => "New York Times Technology",
		:rss_url => "http://feeds.nytimes.com/nyt/rss/Technology"
	},
	{
		:topic   => "Technology",
		:title   => "Euraeka Technology News",
		:rss_url => "http://euraeka.com/technology.rss"
	},
	{
		:topic   => "Business",
		:title   => "New York Times Business",
		:rss_url => "http://feeds.nytimes.com/nyt/rss/Business"
	},
	{
		:topic   => "Business",
		:title   => "Euraeka Business",
		:rss_url => "http://euraeka.com/news/business_society.rss"
	},
	{
		:topic   => "Business",
		:title   => "Yahoo Business",
		:rss_url => "http://rss.news.yahoo.com/rss/business"
	},
	{
		:topic   => "Sports",
		:title   => "New York Times Sports",
		:rss_url => "http://www.nytimes.com/services/xml/rss/nyt/Sports.xml"
	},
	{
		:topic   => "Sports",
		:title   => "Yahoo Sports",
		:rss_url => "http://rss.news.yahoo.com/rss/sports"
	},
	{
		:topic   => "Health",
		:title   => "Yahoo Health",
		:rss_url => "http://rss.news.yahoo.com/rss/health"
	},
	{
		:topic   => "Health",
		:title   => "New York Times Health",
		:rss_url => "http://feeds.nytimes.com/nyt/rss/Health"
	},
	{
		:topic   => "Arts",
		:title   => "New York Times Arts",
		:rss_url => "http://feeds.nytimes.com/nyt/rss/Arts"
	},
	{
		:topic   => "Travel",
		:title   => "New York Times Travel",
		:rss_url => "http://feeds.nytimes.com/nyt/rss/Travel"
	},
	{
		:topic   => "Science",
		:title   => "Euraeka Science News",
		:rss_url => "http://euraeka.com/science.rss"
	},
	{
		:topic   => "Science",
		:title   => "Yahoo Science",
		:rss_url => "http://rss.news.yahoo.com/rss/science"
	},
	{
		:topic   => "Science",
		:title   => "New York Times Science",
		:rss_url => "http://feeds.nytimes.com/nyt/rss/Science"
	},
	{
		:topic   => "Humor",
		:title   => "The Onion",
		:rss_url => "http://feeds.theonion.com/onionnewsnetwork"
	}

].each do |f|
  next if Feed.find_by_rss(f[:rss_url])
  puts "Creating Default (Topic) Feed: (#{f[:topic]}) #{f[:title]}"
  Feed.add_default_feed! f[:rss_url], :topic => f[:topic], :title => f[:title]
end

#######################################################################
# Metadata Settings
#######################################################################
ads = [
  { :key_name => 'default', :key_sub_type => 'banner', :width => "468px", :height => "60px", :background => "default/ads_468_60.gif" },
  { :key_name => 'default', :key_sub_type => 'leaderboard', :width => "728px", :height => "90px", :background => "default/ads_728_90.gif" },
  { :key_name => 'default', :key_sub_type => 'small_square', :width => "200px", :height => "200px", :background => "default/ads_200_200.gif" },
  { :key_name => 'default', :key_sub_type => 'skyscraper', :width => "160px", :height => "600px", :background => "default/ads_160_600.gif" },
  { :key_name => 'default', :key_sub_type => 'square', :width => "250px", :height => "250px", :background => "default/ads_250_250.gif" },
  { :key_name => 'default', :key_sub_type => 'medium_rectangle', :width => "300px", :height => "250px", :background => "default/ads_300_250.gif" },
  { :key_name => 'default', :key_sub_type => 'large_rectangle', :width => "336px", :height => "280px", :background => "default/ads_336_280.gif" }
]
ads.each do |ad|
  next if Metadata::Ad.find_slot(ad[:key_sub_type], ad[:key_name])
  puts "Creating ad slot #{ad[:key_name]} -- #{ad[:key_sub_type]}" if debug

  options = {
    :meta_type => 'config',
    :key_type => 'ads',
    :key_sub_type => ad[:key_sub_type],
		:key_name => ad[:key_name],
		:data => { :name => (ad[:name] || "slot_#{ad[:key_sub_type]}"),
      :width => ad[:width],
      :height => ad[:height],
      :background => ad[:background]
    }
  }
  Metadata::Ad.create!(options)
end

custom_widgets = [
  { :key_name => 'events', :key_sub_type => 'sidebar', :title => "events custom sidebar widget", :content_type => "sidebar_content", :custom_data => '**default**' },
  { :key_name => 'stories', :key_sub_type => 'sidebar', :title => "stories custom sidebar widget", :content_type => "sidebar_content", :custom_data => '**default**' },
  { :key_name => 'articles', :key_sub_type => 'sidebar', :title => "stories custom sidebar widget", :content_type => "sidebar_content", :custom_data => '**default**' },
  { :key_name => 'resources', :key_sub_type => 'sidebar', :title => "resources custom sidebar widget", :content_type => "sidebar_content", :custom_data => '**default**' },
  { :key_name => 'ideas', :key_sub_type => 'sidebar', :title => "ideas custom sidebar widget", :content_type => "sidebar_content", :custom_data => '**default**' },
  { :key_name => 'home', :key_sub_type => 'sidebar', :title => "home custom sidebar widget", :content_type => "sidebar_content", :custom_data => '**default**' },
  { :key_name => 'questions', :key_sub_type => 'sidebar', :title => "questions custom sidebar widget", :content_type => "sidebar_content", :custom_data => '**default**' },
  { :key_name => 'cards', :key_sub_type => 'sidebar', :title => "cards custom sidebar widget", :content_type => "sidebar_content", :custom_data => '**default**' },
  { :key_name => 'forums', :key_sub_type => 'sidebar', :title => "forums custom sidebar widget", :content_type => "sidebar_content", :custom_data => '**default**' }
]
custom_widgets.each do |custom_widget|
  next if Metadata::CustomWidget.find_slot(custom_widget[:key_sub_type], custom_widget[:key_name])
  puts custom_widget[:custom_data]
  puts "Creating custom_widget slot #{custom_widget[:title]} -- #{custom_widget[:key_sub_type]}" if debug

  Metadata::CustomWidget.create!({
    :meta_type => 'custom',
    :key_type => 'widget',
    :key_sub_type => custom_widget[:key_sub_type],
		:key_name => custom_widget[:key_name],
		:data => {
      :title => custom_widget[:title],
      :content_type => custom_widget[:content_type],
      :custom_data => custom_widget[:custom_data]
    }
  })
end

version_file = File.join(Rails.root, "config", "version")
version = File.exist?(version_file) ? File.read(version_file) : "3.4.4"

settings = [
 { :key_sub_type => 'newscloud', :key_name => 'version',  :value => version },
 { :key_sub_type => 'amazon', :key_name => 'aws_access_key_id',  :value => "1234asdf4321" },
 { :key_sub_type => 'amazon', :key_name => 'aws_secret_key',  :value => "123454321asdf5432112345" },
 { :key_sub_type => 'amazon', :key_name => 'associate_code',  :value => "yourcode-20" },
 { :key_sub_type => 'classifieds', :key_name => 'enable_sale_items',  :value => "true" },
 { :key_sub_type => 'tweet_streams', :key_name => 'enable_whitelist',  :value => "true" },
 { :key_sub_type => 'options', :key_name => 'default_admin_user',  :value => (APP_CONFIG['default_admin_user'] || "admin") },
 { :key_sub_type => 'options', :key_name => 'default_admin_password',  :value => (APP_CONFIG['default_admin_password'] || "n2adminpassword") },
 { :key_sub_type => 'options', :key_name => 'default_site_preference',  :value => "iframe" },
 { :key_sub_type => 'options', :key_name => 'animation_speed_features',  :value => "300" },
 { :key_sub_type => 'options', :key_name => 'animation_speed_newswires',  :value => "750" },
 { :key_sub_type => 'options', :key_name => 'animation_speed_widgets',  :value => "1000" },
 { :key_sub_type => 'options', :key_name => 'animation_interval_general',  :value => "1000" },
 { :key_sub_type => 'options', :key_name => 'animation_interval_newswires',  :value => "1000" },
 { :key_sub_type => 'options', :key_name => 'exclude_articles_from_news',  :value => "false" },
 { :key_sub_type => 'options', :key_name => 'enable_gallery_file_uploads',  :value => "false" },
 { :key_sub_type => 'options', :key_name => 'enable_audio_embed',  :value => "false" },
 { :key_sub_type => 'options', :key_name => 'auto_feature_only_moderator_items',  :value => "false", :hint => "Filter auto feature widgets to only use items posted by moderators" },
 { :key_sub_type => 'options', :key_name => 'outbrain_enabled',  :value => "false", :hint => "Enable Outbrain(http://outbrain.com) support" },
 { :key_sub_type => 'options', :key_name => 'outbrain_template_name',  :value => "my_template_name", :hint => "Outbrain template name" },
 { :key_sub_type => 'options', :key_name => 'outbrain_account_id',  :value => "1234567890", :hint => "Outbrain account id" },
 { :key_sub_type => 'options', :key_name => 'outbrain_verification_html',  :value => "false", :hint => "Outbrain verification html, copy paste this from Outbrain." },
 { :key_sub_type => 'options', :key_name => 'hoptoad_api_key',  :value => (APP_CONFIG['hoptoad_api_key'] || "false" ), :hint => "API Key for tracking bugs via HopToadApp" },
 #{ :key_sub_type => 'options', :key_name => 'site_notification_user',  :value => (User.admins.last || nil) },
 { :key_sub_type => 'options', :key_name => 'enable_activity_popups',  :value => "true" },
 { :key_sub_type => 'options', :key_name => 'allow_web_auth',  :value => (APP_CONFIG['allow_web_auth'] || "false" ) },
 { :key_sub_type => 'options', :key_name => 'site_title',  :value => (APP_CONFIG['site_title'] || "Default Site Title" ) },
 { :key_sub_type => 'options', :key_name => 'site_topic', :value => (APP_CONFIG['site_topic'] || "Default Topic" ) },
 { :key_sub_type => 'options', :key_name => 'contact_us',  :value => (APP_CONFIG['contact_us_recipient'] || "admin@email.com,me@email.com,support@email.com" ) },
 { :key_sub_type => 'options', :key_name => 'firstnameonly', :value => (APP_CONFIG['firstnameonly'] || "false" ) },
 { :key_sub_type => 'options', :key_name => 'site_video_url', :value => APP_CONFIG['base_site_url'].gsub("http://","").gsub("www",""), :hint => "used by some sites with custom video URLs e.g. boston.com"},
 { :key_sub_type => 'options', :key_name => 'predictions_max_daily_guesses', :value => 25, :hint => "maximum number of guesses allowed per day"},
 { :key_sub_type => 'options', :key_name => 'predictions_allow_suggestions',  :value => true },
 { :key_sub_type => 'design', :key_name => 'typekit', :value => (APP_CONFIG['typekit'] || "000000" ) },
 { :key_sub_type => 'twitter', :key_name => 'account', :value =>(APP_CONFIG['twitter_account'] || "userkey_name" ) },
 { :key_sub_type => 'twitter', :key_name => 'oauth_key', :value => (APP_CONFIG['twitter_oauth_key'] || "U6qjcn193333331AuA" ) },
 { :key_sub_type => 'twitter', :key_name => 'oauth_secret', :value => (APP_CONFIG['twitter_oauth_secret'] || "Heu0GGaRuzn762323gg0qFGWCp923viG8Haw" ) },
 { :key_sub_type => 'twitter', :key_name => 'oauth_consumer_key', :value => (APP_CONFIG['twitter_oauth_key'] || "U6qjcn193333331AuA" ) },
 { :key_sub_type => 'twitter', :key_name => 'oauth_consumer_secret', :value => (APP_CONFIG['twitter_oauth_secret'] || "Heu0GGaRuzn762323gg0qFGWCp923viG8Haw" ) },
 { :key_sub_type => 'twitter', :key_name => 'tweet_default_min_votes', :value => (APP_CONFIG['tweet_default_min_votes'] || "15" ) },
 { :key_sub_type => 'twitter', :key_name => 'tweet_default_limit', :value => (APP_CONFIG['tweet_default_limit'] || "3" ) },
 { :key_sub_type => 'twitter', :key_name => 'tweet_events_min_votes', :value => (APP_CONFIG['tweet_events_min_votes'] || "15" ) },
 { :key_sub_type => 'twitter', :key_name => 'tweet_events_limit', :value => (APP_CONFIG['tweet_events_limit'] || "3" ) },
 { :key_sub_type => 'twitter', :key_name => 'tweet_stories_min_votes', :value => (APP_CONFIG['tweet_stories_min_votes'] || "15" ) },
 { :key_sub_type => 'twitter', :key_name => 'tweet_stories_limit', :value => (APP_CONFIG['tweet_stories_limit'] || "3" ) },
 { :key_sub_type => 'twitter', :key_name => 'tweet_questions_min_votes', :value => (APP_CONFIG['tweet_questions_min_votes'] || "15" ) },
 { :key_sub_type => 'twitter', :key_name => 'tweet_questions_limit', :value => (APP_CONFIG['tweet_questions_limit'] || "3" ) },
 { :key_sub_type => 'twitter', :key_name => 'tweet_ideas_min_votes', :value => (APP_CONFIG['tweet_ideas_min_votes'] || "15" ) },
 { :key_sub_type => 'twitter', :key_name => 'tweet_ideas_limit', :value => (APP_CONFIG['tweet_ideas_limit'] || "3" ) },
 { :key_sub_type => 'twitter', :key_name => 'tweet_featured_items', :value =>(APP_CONFIG['tweet_featured_items'] || "true" ) },
 { :key_sub_type => 'twitter', :key_name => 'tweet_popular_items', :value =>"false" },
 { :key_sub_type => 'twitter', :key_name => 'tweet_all_moderator_items', :value =>"false", :hint => 'Tweet all items posted by moderators' },
 { :key_sub_type => 'bitly', :key_name => 'bitly_username', :value =>(APP_CONFIG['bitly_username'] || "username" ) },
 { :key_sub_type => 'bitly', :key_name => 'bitly_api_key', :value =>(APP_CONFIG['bitly_api_key'] || "api_key" ) },
 { :key_sub_type => 'facebook', :key_name => 'app_id', :value => (APP_CONFIG['facebook_application_id'] || "111111111111" ) },
 { :key_sub_type => 'welcome_panel', :key_name => 'welcome_layout', :value => "default", :hint => 'e.g. default, thumb, host, banner' },
 { :key_sub_type => 'welcome_panel', :key_name => 'welcome_image_url', :value => APP_CONFIG['base_site_url']+"/images/default/icon-fan-app.gif", :hint => "Full (absolute) URL to image, e.g. #{APP_CONFIG['base_site_url']}/images/default/icon-fan-app.gif, recommended sizes: thumb 50 x 50 or banner = 300 x 90"},
 { :key_sub_type => 'welcome_panel', :key_name => 'welcome_host', :value => "0", :hint => 'userid of host profile image to use'},
 { :key_sub_type => 'options', :key_name => 'limit_daily_member_posts',  :value => "25" },
 { :key_sub_type => 'stats', :key_name => 'google_analytics_account_id', :value => (APP_CONFIG['google_analytics_account_id'] || "UF-123456890-7" ) },
 { :key_sub_type => 'stats', :key_name => 'google_analytics_site_id', :value => (APP_CONFIG['google_analytics_site_id'] || "1231232" ) },
 { :key_sub_type => 'sitemap', :key_name => 'google-site-verification', :value => "WS8kMC8-Ds77777777777Xy6QcmRpWAfY" },
 { :key_sub_type => 'sitemap', :key_name => 'yahoo-site-verification', :value => "WS87ds77" },
 { :key_sub_type => 'sitemap', :key_name => 'yahoo_app_id',  :value => (APP_CONFIG['yahoo_app_id'] || "ELIZq2L333322.rGdRR5abc888HCGL1zDOegJakZyHIrugVqPip3YK333P8-") },
 { :key_sub_type => 'ads', :key_name => 'sponsor_zones_enabled', :value => "false" },
 { :key_sub_type => 'ads', :key_name => 'sponsor_zones_store_url', :value => "http://newscloud.trafficspaces.com", :hint => "The website URL used to sell your sponsored ad zones"  },
 { :key_sub_type => 'ads', :key_name => 'platform', :value => (APP_CONFIG['ad_platform'] || "default" ) },
 { :key_sub_type => 'ads', :key_name => 'helios_sitepage', :value => (APP_CONFIG['helios_sitepage'] || "youraddomain.com/yourfacebookproject.htm" ) },
 { :key_sub_type => 'ads', :key_name => 'helios_url', :value => (APP_CONFIG['helios_url'] || "http://subdomain.xxx.com" ) },
 { :key_sub_type => 'ads', :key_name => 'helios_script_url', :value => (APP_CONFIG['helios_script_url'] || "http://scriptsubdomain.xxx.com" ) },
 { :key_sub_type => 'ads', :key_name => 'helios_list_pos', :value => (APP_CONFIG['helios_list_pos'] || "728x90_1,468x60_1,300x250_1,160x600_1,250x250_1,200x200_1,336x280_1" ) },
 { :key_sub_type => 'ads', :key_name => 'helios_slot_name', :value => (APP_CONFIG['helios_slot_name'] || "default" ) },
 { :key_sub_type => 'ads', :key_name => 'openx_slot_name', :value => (APP_CONFIG['openx_slot_name'] || "default" ) },
 { :key_sub_type => 'ads', :key_name => 'openx_zone_banner', :value => "1" },
 { :key_sub_type => 'ads', :key_name => 'openx_zone_leaderboard', :value => "2" },
 { :key_sub_type => 'ads', :key_name => 'openx_zone_small_square', :value => "3" },
 { :key_sub_type => 'ads', :key_name => 'openx_zone_skyscraper', :value => "4" },
 { :key_sub_type => 'ads', :key_name => 'openx_zone_square', :value => "5" },
 { :key_sub_type => 'ads', :key_name => 'openx_zone_medium_rectangle', :value => "6" },
 { :key_sub_type => 'ads', :key_name => 'openx_zone_large_rectangle', :value => "7" },
 { :key_sub_type => 'ads', :key_name => 'openx_url_m3_u', :value => (APP_CONFIG['openx_slot_url'] || "http://openx.com/m3_u_address" ) },
 { :key_sub_type => 'ads', :key_name => 'openx_noscript_href', :value => "http://openx.com/ns_href_address" },
 { :key_sub_type => 'ads', :key_name => 'openx_noscript_imgsrc', :value => "http://openx.com/ns_imgsrc_address" },
 { :key_sub_type => 'ads', :key_name => 'google_adsense_slot_name', :value => ( APP_CONFIG['google_adsense_slot_name'] || "default") },
 { :key_sub_type => 'ads', :key_name => 'google_adsense_account_id', :value => (APP_CONFIG['google_adsense_account_id'] || "ca-pub-9975156792632579" ) },
 { :key_sub_type => 'options', :key_name => 'google_search_engine_id', :value => ("your-google-search-engine-id") },
 { :key_sub_type => 'options', :key_name => 'widget_stories_short_max', :value => "3" },
 { :key_sub_type => 'options', :key_name => 'widget_articles_as_blog_max', :value => "1" },
 { :key_sub_type => 'zvents', :key_name => 'zvents_replacement_url', :value => ("www.zvents.com") },
 { :key_sub_type => 'zvents', :key_name => 'zvent_api_key', :value => (APP_CONFIG['zvent_api_key'] || "false" ) },
 { :key_sub_type => 'zvents', :key_name => 'zvent_location', :value => (APP_CONFIG['zvent_location'] || "false" ) },
 { :key_sub_type => 'twitter_standard_favorites', :key_name => 'favorites_account', :value =>"twitter-account", :hint => 'The account name of the Twitter account to show favorites from' },
 { :key_sub_type => 'twitter_standard_favorites', :key_name => 'favorites_widget_title', :value =>"Selected tweets from", :hint => 'A title for the favorites widget' },
 { :key_sub_type => 'twitter_standard_favorites', :key_name => 'favorites_widget_caption', :value => (APP_CONFIG['site_title'] || "Default Title"), :hint => 'A subject for the favorites widget' },
 { :key_sub_type => 'twitter_standard_search', :key_name => 'search', :value =>"search-value", :hint => 'The account name of the Twitter account to show search from' },
 { :key_sub_type => 'twitter_standard_search', :key_name => 'search_widget_title', :value =>"Tweets about", :hint => 'A title for the search widget' },
 { :key_sub_type => 'twitter_standard_search', :key_name => 'search_widget_caption', :value => (APP_CONFIG['site_topic'] || "Default Topic" ), :hint => 'A subject for the search widget' },
 { :key_sub_type => 'twitter_standard_list', :key_name => 'list_account', :value =>"twitter-account", :hint => 'The account name which owns the Twitter list' },
 { :key_sub_type => 'twitter_standard_list', :key_name => 'list_name', :value =>"default-list", :hint => 'The hyphenated name of the twitter list' },
 { :key_sub_type => 'twitter_standard_list', :key_name => 'list_widget_title', :value => (APP_CONFIG['site_title'] || "Default Title"), :hint => 'The title for the widget' },
 { :key_sub_type => 'twitter_standard_list', :key_name => 'list_widget_caption', :value =>"Tweets about #{(APP_CONFIG['site_topic'] || "Default Topic" )}", :hint => 'The caption for the widget' },
 { :key_sub_type => 'options', :key_name => 'rackspace_hosting_credit',  :value => "false" , :hint => 'If you are using credited Rackspace hosting, please activate this setting.' },
 { :key_sub_type => 'options', :key_name => 'native_voting',  :value => "false" , :hint => 'False turns on Add This toolbar with Facebook Likes. True turns on native likes and Twitter Connect.' },
 { :key_sub_type => 'options', :key_name => 'framed_item_content',  :value => "false" , :hint => 'True makes links to destination item urls appear in a frameset.' },
 { :key_sub_type => 'options', :key_name => 'extended_footer_content',  :value => "false" , :hint => 'Advanced users only - place additional javascript for the footer here.' },
 { :key_sub_type => 'facebook', :key_name => 'display_facebook_app_badge',  :value => "false" , :hint => 'Display App badge from Facebook in footer' },
]

settings.each do |setting|
  next if Metadata::Setting.find_setting(setting[:key_name], setting[:key_sub_type])
  puts "Creating setting #{setting[:key_name]} -- #{setting[:key_sub_type]}" if debug

  Metadata::Setting.create!({
		:data => {
		  :setting_sub_type_name => setting[:key_sub_type],
		  :setting_name => setting[:key_name],
		  :setting_value => setting[:value],
		  :setting_hint => (setting[:hint] || "")
		  }
  })
end

activity_scores = [
 { :key_sub_type => 'importance', :key_name => 'karma',  :value => 3, :hint => "Multiple used when calculating karma actions. High setting maximizes impact of quality of posts as judged by other readers" },
 { :key_sub_type => 'importance', :key_name => 'participation',  :value => 1, :hint => "Multiple used when calculating participation actions. Low setting minimizes impact of posting on user scores." },
 { :key_sub_type => 'participation', :key_name => 'story',  :value => 1, :hint => "Points awarded when user creates a story" },
 { :key_sub_type => 'participation', :key_name => 'article',  :value => 1, :hint => "Points awarded when user creates a article" },
 { :key_sub_type => 'participation', :key_name => 'idea',  :value => 1, :hint => "Points awarded when user creates a idea" },
 { :key_sub_type => 'participation', :key_name => 'event',  :value => 1, :hint => "Points awarded when user creates a event" },
 { :key_sub_type => 'participation', :key_name => 'topic',  :value => 1, :hint => "Points awarded when user creates a topic" },
 { :key_sub_type => 'participation', :key_name => 'resource',  :value => 1, :hint => "Points awarded when user creates a resource" },
 { :key_sub_type => 'participation', :key_name => 'question',  :value => 1, :hint => "Points awarded when user creates a question" },
 { :key_sub_type => 'participation', :key_name => 'answer',  :value => 1, :hint => "Points awarded when user creates a answer" },
 { :key_sub_type => 'participation', :key_name => 'comment',  :value => 1, :hint => "Points awarded when user creates a comment" },
 { :key_sub_type => 'participation', :key_name => 'share',  :value => 1, :hint => "Points awarded when user shares another reader\'s item" },
 { :key_sub_type => 'participation', :key_name => 'invite',  :value => 1, :hint => "Points awarded when user invites a friend" },
 { :key_sub_type => 'karma', :key_name => 'item_vote',  :value => 1, :hint => "Points awarded when item created by user is liked" },
 { :key_sub_type => 'karma', :key_name => 'item_comment',  :value => 1, :hint => "Points awarded when item created by user is commented on" },
 { :key_sub_type => 'karma', :key_name => 'item_shared',  :value => 1, :hint => "Points awarded when item created by user is shared or tweeted" },
 { :key_sub_type => 'karma', :key_name => 'invite_accepted',  :value => 1, :hint => "Points awarded when invite from user is accepted" }
]

activity_scores.each do |activity_score|
  next if Metadata::ActivityScore.find_activity_score(activity_score[:key_name], activity_score[:key_sub_type])
  puts "Creating activity_score #{activity_score[:key_name]} -- #{activity_score[:key_sub_type]}" if debug

  Metadata::ActivityScore.create!({
		:data => {
		  :activity_score_sub_type_name => activity_score[:key_sub_type],
		  :activity_score_name => activity_score[:key_name],
		  :activity_score_value => activity_score[:value],
		  :activity_score_hint => (activity_score[:hint] || "")
		  }
  })
end

ad_layouts = [
 { :key_sub_type => 'ad_layouts', :key_name => 'default', :layout => "Leader_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'stories_index', :layout => "Banner_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'articles_index', :layout => "Banner_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'resources_index', :layout => "Leader_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'resource_sections_index', :layout => "Leader_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'ideas_index', :layout => "Leader_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'idea_boards_index', :layout => "Leader_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'events_index', :layout => "Leader_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'forums_index', :layout => "Leader_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'topics_index', :layout => "Leader_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'questions_index', :layout => "Leader_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'users_index', :layout => "Leader_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'stories_item', :layout => "Banner_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'articles_item', :layout => "Banner_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'resources_item', :layout => "Banner_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'ideas_item', :layout => "Banner_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'resource_sections_item', :layout => "Banner_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'idea_boards_item', :layout => "Banner_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'events_item', :layout => "Banner_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'forums_item', :layout => "Banner_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'topics_item', :layout => "Banner_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'questions_item', :layout => "Banner_A" },
 { :key_sub_type => 'ad_layouts', :key_name => 'users_item', :layout => "Banner_A" }
]

ad_layouts.each do |ad_layout|
  next if Metadata::AdLayout.get(ad_layout[:key_name])
  puts "Creating ad layout #{ad_layout[:key_name]} -- #{ad_layout[:layout]}" if debug

  Metadata::AdLayout.create!({
		:data => {
		  :ad_layout_sub_type_name => ad_layout[:key_sub_type],
		  :ad_layout_name => ad_layout[:key_name],
		  :ad_layout_layout => ad_layout[:layout],
		  :ad_layout_hint => (ad_layout[:hint] || "")
		  }
  })
end

sponsor_zones = [
 { :sponsor_zone_name => 'home', :sponsor_zone_topic => 'default',  :sponsor_zone_code => "xxxxxxxxx" },
 { :sponsor_zone_name => 'stories', :sponsor_zone_topic => 'default',  :sponsor_zone_code => "xxxxxxxxx" },
 { :sponsor_zone_name => 'articles', :sponsor_zone_topic => 'default',  :sponsor_zone_code => "xxxxxxxxx" },
 { :sponsor_zone_name => 'questions', :sponsor_zone_topic => 'default',  :sponsor_zone_code => "xxxxxxxxx" },
 { :sponsor_zone_name => 'ideas', :sponsor_zone_topic => 'default',  :sponsor_zone_code => "xxxxxxxxx" },
 { :sponsor_zone_name => 'forums', :sponsor_zone_topic => 'default',  :sponsor_zone_code => "xxxxxxxxx" },
 { :sponsor_zone_name => 'resources', :sponsor_zone_topic => 'default',  :sponsor_zone_code => "xxxxxxxxx" },
 { :sponsor_zone_name => 'events', :sponsor_zone_topic => 'default',  :sponsor_zone_code => "xxxxxxxxx" }
]

sponsor_zones.each do |sponsor_zone|
  next if Metadata::SponsorZone.get(sponsor_zone[:sponsor_zone_name], sponsor_zone[:sponsor_zone_topic])
  puts "Creating sponsor_zone #{sponsor_zone[:sponsor_zone_name]} -- #{sponsor_zone[:sponsor_zone_topic]}" if debug

  Metadata::SponsorZone.create!({
		:data => {
		  :sponsor_zone_name => sponsor_zone[:sponsor_zone_name],
		  :sponsor_zone_topic => sponsor_zone[:sponsor_zone_topic],
		  :sponsor_zone_code => sponsor_zone[:sponsor_zone_code]
		  }
  })
end


#######################################################################
# View Tree
#######################################################################

#
# View Object Templates
#
view_object_templates =
  [
   {
     :name        => "v2_welcome_panel",
     :pretty_name => "Version 2 Welcome Panel",
     :template    => "shared/templates/single_col_welcome_panel",
     :min_items => nil,
     :max_items => nil
   },
   {
     :name        => "v2_single_col_list_with_profile",
     :pretty_name => "Version 2 Single Column List With Profile",
     :template    => "shared/templates/single_col_list_with_profile",
     :min_items => 1
   },
   {
     :name        => "v2_single_facebook_widget",
     :pretty_name => "Version 2 Single Column Facebook Widget",
     :template    => "shared/templates/single_col_facebook_widget",
     :min_items => nil,
     :max_items => nil
   },
   {
     :name        => "v2_single_col_user_list",
     :pretty_name => "Version 2 Single Column User List",
     :template    => "shared/templates/single_col_user_list",
     :min_items => 1
   },
   {
     :name        => "v2_single_col_gallery_strip",
     :pretty_name => "Version 2 Single Column Gallery Strip",
     :template    => "shared/templates/single_col_gallery_strip",
     :min_items => 1
   },
   {
     :name        => "v2_single_col_gallery_big_image",
     :pretty_name => "Version 2 Single Column Gallery Big Image",
     :template    => "shared/templates/single_col_gallery_big_image",
     :min_items => 1
   },
   {
     :name        => "v2_double_col_gallery_strip",
     :pretty_name => "Version 2 Double Column Gallery Strip",
     :template    => "shared/templates/double_col_gallery_strip",
     :min_items => 1
   },
   {
     :name        => "twitter_standard_list",
     :pretty_name => "Twitter Standard List",
     :template    => "shared/sidebar/twitter_standard_list",
     :min_items => nil,
     :max_items => nil
   },
   {
     :name        => "twitter_standard_favorites",
     :pretty_name => "Twitter Standard Favorites",
     :template    => "shared/sidebar/twitter_standard_favorites",
     :min_items => nil,
     :max_items => nil
   },
   {
     :name        => "twitter_standard_profile",
     :pretty_name => "Twitter Standard Profile",
     :template    => "shared/sidebar/twitter_standard_profile",
     :min_items => nil,
     :max_items => nil
   },
   {
     :name        => "twitter_standard_search",
     :pretty_name => "Twitter Standard Search",
     :template    => "shared/sidebar/twitter_standard_search",
     :min_items => nil,
     :max_items => nil
   },   
   {
     :name        => "v2_ad_template",
     :pretty_name => "Version 2 Ad Template",
     :template    => "shared/templates/ad_template",
     :min_items => nil,
     :max_items => nil
   },
   {
     :name        => "v2_single_col_custom_widget",
     :pretty_name => "Version 2 Single Column Custom Widget",
     :template    => "shared/templates/single_col_custom_widget",
     :min_items => nil,
     :max_items => nil
   },
   {
     :name        => "v2_double_col_custom_widget",
     :pretty_name => "Version 2 Double Column Custom Widget",
     :template    => "shared/templates/double_col_custom_widget",
     :min_items => nil,
     :max_items => nil
   },
   {
     :name        => "v2_triple_col_custom_widget",
     :pretty_name => "Version 2 Triple Column Custom Widget",
     :template    => "shared/templates/triple_col_custom_widget",
     :min_items => nil,
     :max_items => nil
   },
   # V3 widgets
   {
     :name        => "v3_triple_col_1_large_4_small",
     :pretty_name => "Version 3 Triple Column 1 Large 4 Small Widget",
     :template    => "shared/templates/v3/triple_col_1_large_4_small",
     :min_items => 5,
     :max_items => 5
   },
   {
     :name        => "v3_triple_col_2_large",
     :pretty_name => "Version 3 Triple Column 2 Large Widget",
     :template    => "shared/templates/v3/triple_col_2_large",
     :min_items => 2,
     :max_items => 2
   },
   {
     :name        => "v3_triple_col_1_large_2_small_3_links",
     :pretty_name => "Version 3 Triple Column 1 Large 2 Small 3 Links Widget",
     :template    => "shared/templates/v3/triple_col_1_large_2_small_3_links",
     :min_items => 6,
     :max_items => 6
   },
   {
     :name        => "v3_triple_col_2_medium_2_links",
     :pretty_name => "Version 3 Triple Column 2 medium 2 links",
     :template    => "shared/templates/v3/triple_col_2_medium_2_links",
     :min_items => 4,
     :max_items => 4
   },
   {
     :name        => "v3_double_col_1_large_2_small",
     :pretty_name => "Version 3 Double Column 1 Large 2 Small",
     :template    => "shared/templates/v3/double_col_1_large_2_small",
     :min_items => 3,
     :max_items => 3
   },
   {
     :name        => "v3_double_col_2_medium",
     :pretty_name => "Version 3 Double Column 2 Medium",
     :template    => "shared/templates/v3/double_col_2_medium",
     :min_items => 2,
     :max_items => 2
   },
   {
     :name        => "v3_double_col_2_small_3_medium_links",
     :pretty_name => "Version 3 Double Column 2 small 3 medium links",
     :template    => "shared/templates/v3/double_col_2_small_3_medium_links",
     :min_items => 5,
     :max_items => 5
   },
   {
     :name        => "v3_double_col_3_medium_links_2_small",
     :pretty_name => "Version 3 Double Column 3 Medium Links 2 Small",
     :template    => "shared/templates/v3/double_col_3_medium_links_2_small",
     :min_items => 5,
     :max_items => 5
   },
   {
     :name        => "v3_double_col_2_medium_links_1_medium",
     :pretty_name => "Version 3 Double Column 2 Medium Links 1 Medium",
     :template    => "shared/templates/v3/double_col_2_medium_links_1_medium",
     :min_items => 3,
     :max_items => 3     
   },
   {
     :name        => "v3_double_col_1_medium_2_medium_links",
     :pretty_name => "Version 3 Double Column 1 Medium 2 Medium Links",
     :template    => "shared/templates/v3/double_col_1_medium_2_medium_links",
     :min_items => 3,
     :max_items => 3
   },
   {
     :name        => "v3_double_col_item_list",
     :pretty_name => "Version 3 Double Column Item List",
     :template    => "shared/templates/v3/double_col_item_list",
     :min_items => 5
   },
   {
     :name        => "v3_single_col_featured_item",
     :pretty_name => "Version 3 Single Column Featured Item",
     :template    => "shared/templates/v3/single_col_featured_item",
     :min_items => 1,
     :max_items => 1
   },
   {
     :name        => "v3_single_col_medium",
     :pretty_name => "Version 3 Single Column Medium",
     :template    => "shared/templates/v3/single_col_medium",
     :min_items => 1,
     :max_items => 1
   },
   {
     :name        => "v3_single_col_item_list",
     :pretty_name => "Version 3 Single Column Item List",
     :template    => "shared/templates/v3/single_col_item_list",
     :min_items => 1
   },
   {
     :name        => "v3_single_col_post_story",
     :pretty_name => "Version 3 Single Column Post Story",
     :template    => "shared/templates/v3/single_col_post_story"
   },
   {
     :name        => "v3_triple_col_3_medium",
     :pretty_name => "Version 3 Triple Column 3 Medium Skybox",
     :template    => "shared/templates/v3/triple_col_3_medium",
     :min_items => 3,
     :max_items => 3
   },
   {
     :name        => "v3_triple_col_4_small",
     :pretty_name => "Version 3 Triple Column 4 Small Skybox",
     :template    => "shared/templates/v3/triple_col_4_small",
     :min_items => 4,
     :max_items => 4
   },
  ]
view_object_templates.each do |view_object_template|
  puts "Creating View Object Template: #{view_object_template[:name]} (#{view_object_template[:template]})" if debug and ViewObjectTemplate.find_by_name(view_object_template[:name]).nil?
  vot = ViewObjectTemplate.find_or_create_by_name(view_object_template)
  if vot.min_items != view_object_template[:min_items] or vot.max_items != view_object_template[:max_items]
    puts "Updating View Object Template: #{view_object_template[:name]} -- min_items: #{vot.min_items} --> #{view_object_template[:min_items]} -- max_items: #{vot.max_items} --> #{view_object_template[:max_items]}"
    vot.update_attributes(view_object_template)
  end
end

#
# View Objects
#
view_objects = [
  {
  	:name          => "Welcome Panel",
  	:template_name => "v2_welcome_panel",
  	:settings      => {
                    :klass_name      => "User",
                    :cache_disabled => true,
                    :version => 2,
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
  		:kommands        => [
  		]
  	}
  },
  {
  	:name          => "Newswire",
  	:template_name => "v2_single_col_small_list",
  	:settings      => {
  		:klass_name      => "Newswire",
  		:locale_title    => "newest_newswires_title",
  		:locale_subtitle => nil,
  		:use_post_button => false,
  		:kommands        => [
  		  {
          :method_name => "active"
        },
  		  {
          :method_name => "unpublished"
        },
  		  {
          :method_name => "newest",
          :args        => [5]
        }
  		]
  	}
  },
  {
  	:name          => "Featured Gallery Single Column Small Strip",
  	:template_name => "v2_single_col_gallery_strip",
  	:settings      => {
  		:klass_name      => "Gallery",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
  		:kommands        => [
  		  {
          :method_name => "featured"
        }
  		]
  	}
  },
  {
  	:name          => "Top Gallery Single Column Big Image",
  	:template_name => "v2_single_col_gallery_big_image",
  	:settings      => {
  		:klass_name      => "Gallery",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
  		:kommands        => [
  		  {
          :method_name => "top"
        }
  		]
  	}
  },
  {
  	:name          => "Newest Gallery Double Column Small Strip",
  	:template_name => "v2_double_col_gallery_strip",
  	:settings      => {
  		:klass_name      => "Gallery",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
  		:kommands        => [
  		  {
          :method_name => "newest"
        }
  		]
  	}
  },
  {
  	:name          => "Recent Users",
  	:template_name => "v2_single_col_user_list",
  	:settings      => {
  		:klass_name      => "User",
  		:locale_title    => "recent_users_without_count",
  		:locale_subtitle => nil,
                    :use_post_button => false,
                    :cache_disabled => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "active"
        },
  		  {
          :method_name => "members"
        },
  		  {
          :method_name => "recently_active",
          :args        => [20]
        }
  		]
  	}
  },
  {
  	:name          => "Newest Stories",
  	:template_name => "v3_single_col_item_list",
  	:settings      => {
  		:klass_name      => "Content",
  		:locale_title    => "shared.sidebar.newest_stories.newest_stories_title",
  		:locale_subtitle => nil,
                    :use_post_button => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "newest",
          :args        => [5]
        }
  		]
  	}
  },
  {
  	:name          => "Newest Stories Double Column Item List",
  	:template_name => "v3_double_col_1_medium_2_medium_links",
  	:settings      => {
  		:klass_name      => "Content",
  		:locale_title    => "shared.sidebar.newest_stories.newest_stories_title",
  		:locale_subtitle => "shared.stories.stories_subtitle",
                    :use_post_button => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "newest",
          :args        => [3]
        }
  		]
  	}
  },
  {
  	:name          => "Newest Univeral Items Double Column List",
  	:template_name => "v3_double_col_1_medium_2_medium_links",
  	:settings      => {
  		:klass_name      => "ItemAction",
  		:locale_title    => "generic.newest_items.title",
  		:locale_subtitle => "generic.newest_items.subtitle",
                    :use_post_button => false,
                    :version => 3,
  		:kommands        => [
  		  {
          :method_name => "newest_items",
          :args        => [3]
        }
  		]
  	}
  },
  {
  	:name          => "Top Stories",
  	:template_name => "v3_single_col_item_list",
  	:settings      => {
  		:klass_name      => "Content",
  		:locale_title    => "shared.sidebar.top_stories.top_stories_title",
                    :locale_subtitle => nil,
                    :version => 2,
  		:use_post_button => true,
  		:kommands        => [
  		  {
          :method_name => "top_items",
          :args        => [5, false]
        }
  		]
  	}
                },
                {
                  :name          => "Top Items Triple Column 3 Medium Skybox",
                  :template_name => "v3_triple_col_3_medium",
                  :settings      => {
                    :version => 4,
                    :klass_name      => "ItemScore",
                    :locale_title    => "generic.top_items.title",
                    :locale_subtitle => nil,
                    :use_post_button => false,
                    :kommands        => [
                                         {
                                           :method_name => "top_items",
                                           :args        => [3]
                                         }
                                        ]
                  }
                },
                {
                  :name          => "Top Items Triple Column 4 Small Skybox",
                  :template_name => "v3_triple_col_4_small",
                  :settings      => {
                    :version => 4,
                    :klass_name      => "ItemScore",
                    :locale_title    => "generic.top_items.title",
                    :locale_subtitle => nil,
                    :use_post_button => false,
                    :kommands        => [
                                         {
                                           :method_name => "top_items",
                                           :args        => [4]
                                         }
                                        ]
                  }
                },
  {
  	:name          => "Top Story Single Column Item",
  	:template_name => "v3_single_col_featured_item",
  	:settings      => {
  		:klass_name      => "ItemScore",
  		:locale_title    => "shared.sidebar.top_stories.top_stories_title",
  		:locale_subtitle => "shared.stories.stories_subtitle",
                    :use_post_button => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "top_items",
          :args        => [1]
        }
  		]
  	}
  },
                {
                  # TODO: delete this view object?
  	:name          => "Newest Story Double Column Item",
  	:template_name => "v2_double_col_item",
  	:settings      => {
  		:klass_name      => "Content",
  		:locale_title    => "shared.sidebar.newest_stories.newest_stories_title",
  		:locale_subtitle => nil,
  		:use_post_button => true,
  		:kommands        => [
  		  {
          :method_name => "newest",
          :args        => [1]
        }
  		]
  	}
  },
  {
  	:name          => "Top Classifieds",
  	:template_name => "v3_single_col_item_list",
  	:settings      => {
  		:klass_name      => "Classified",
  		:locale_title    => "classifieds.top_classifieds_title",
  		:locale_subtitle => nil,
  		:use_post_button => true,
      :version => 3,
      :kommands        => [
  		  {
  		    :method_name => "available"
  		  },
  		  {
  		    :method_name => "allow_all"
  		  },
  		  {
          :method_name => "top",
          :args        => [5]
        }
  		]
  	}
  },
  {
  	:name          => "Random Question",
  	:template_name => "v3_single_col_featured_item",
  	:settings      => {
  		:klass_name      => "Question",
  		:locale_title    => "questions.random_questions_title",
  		:locale_subtitle => nil,
                    :use_post_button => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "view_object_random_item"
        }
  		]
  	}
  },
  {
  	:name          => "Random Prediction Question",
  	:template_name => "v3_single_col_featured_item",
  	:settings      => {
  		:klass_name      => "PredictionQuestion",
  		:locale_title    => "predictions.random_predictions_title",
  		:locale_subtitle => nil,
                    :use_post_button => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "approved"
        },
  		  {
          :method_name => "currently_open"
        },
        {
          :method_name => "view_object_random_item"
        }
  		]
  	}
  },
  {
  	:name          => "Newest Prediction Questions",
  	:template_name => "v3_single_col_item_list",
  	:settings      => {
  		:klass_name      => "PredictionQuestion",
  		:locale_title    => "predictions.newest_predictions_title",
  		:locale_subtitle => nil,
                    :use_post_button => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "approved"
        },
  		  {
          :method_name => "currently_open"
        },
  		  {
          :method_name => "newest",
          :args        => [5]
        }
  		]
  	}
  },
  {
  	:name          => "Newest Questions",
  	:template_name => "v3_single_col_item_list",
  	:settings      => {
  		:klass_name      => "Question",
  		:locale_title    => "questions.newest_questions_title",
  		:locale_subtitle => nil,
                    :use_post_button => true,
                    :version => 3,
  		:kommands        => [
  		  {
          :method_name => "newest",
          :args        => [3]
        }
  		]
  	}
  },
  {
  	:name          => "Newest Resources",
  	:template_name => "v3_single_col_item_list",
  	:settings      => {
  		:klass_name      => "Resource",
  		:locale_title    => "resources.newest_resources_title",
  		:locale_subtitle => nil,
                    :use_post_button => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "newest",
          :args        => [5]
        }
  		]
  	}
  },
  {
  	:name          => "Newest Universal Items",
  	:template_name => "v2_single_col_list_with_profile",
  	:settings      => {
  		:klass_name      => "ItemAction",
  		:locale_title    => "generic.newest_items.title",
  		:locale_subtitle => nil,
  		:use_post_button => false,
                    :css_class       => "active",
                    :version => 3,
  		:kommands        => [
  		  {
  		    :method_name => "newest_items",
          :args        => [5]
  		  }
  		]
  	}
  },
  {
  	:name          => "Top Universal Items",
  	:template_name => "v3_single_col_item_list",
  	:settings      => {
  		:klass_name      => "ItemScore",
  		:locale_title    => "generic.top_items.title",
  		:locale_subtitle => nil,
  		:use_post_button => false,
                    :css_class       => "active",
                    :version => 7,
  		:kommands        => [
  		  {
                                       :method_name => "top_items",
                                       :args => [5]
  		  }
  		]
  	}
  },
  {
  	:name          => "Triple Item Featured Widget",
  	:template_name => "v3_triple_col_1_large_2_small_3_links",
  	:settings      => {
  		:klass_name      => "ItemScore",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
                    :use_post_button => true,
                    :version => 2,
                    :kommands        => [
                                         :method_name => "top_items",
                                         :args => [6]
  		]
  	}
  },
  {
  	:name          => "Newest Classifieds",
  	:template_name => "v3_single_col_item_list",
  	:settings      => {
  		:klass_name      => "Classified",
  		:locale_title    => "classifieds.newest_classifieds_title",
  		:locale_subtitle => nil,
  		:use_post_button => true,
                    :version => 3,
  		:kommands        => [
  		  {
  		    :method_name => "available"
  		  },
  		  {
  		    :method_name => "allow_all"
  		  },
  		  {
          :method_name => "newest",
          :args        => [3]
        }
  		]
  	}
  },
  {
  	:name          => "Newest Topics",
  	:template_name => "v3_single_col_item_list",
  	:settings      => {
  		:klass_name      => "Topic",
  		:locale_title    => "forums.newest_topics_title",
  		:locale_subtitle => nil,
                    :use_post_button => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "newest"
        }
  		]
  	}
  },
  {
  	:name          => "Newest Articles Feature",
  	:template_name => "v2_double_col_feature",
  	:settings      => {
  		:klass_name      => "Article",
  		:locale_title    => "articles.newest_title",
  		:locale_subtitle => nil,
  		:use_post_button => false,
  		:kommands        => [
  		  {
          :method_name => "published"
        },
  		  {
          :method_name => "newest",
          :args        => [1]
        }
  		]
  	}
  },
  {
  	:name          => "Twitter Standard List",
  	:template_name => "twitter_standard_list",
  	:settings      => {
  		:klass_name      => "Content",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
                    :cache_disabled   => true,
                    :version => 2,
      :old_widget      => true,
  		:kommands        => [
  		]
  	}
                },
  {
  	:name          => "Twitter Standard Favorites",
  	:template_name => "twitter_standard_favorites",
  	:settings      => {
  		:klass_name      => "Content",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
                    :cache_disabled   => true,
                    :version => 2,
      :old_widget      => true,
  		:kommands        => [
  		]
  	}
                },
  {
  	:name          => "Twitter Standard Profile",
  	:template_name => "twitter_standard_profile",
  	:settings      => {
  		:klass_name      => "Content",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
                    :cache_disabled   => true,
                    :version => 2,
      :old_widget      => true,
  		:kommands        => [
  		]
  	}
                },
  {
  	:name          => "Twitter Standard Search",
  	:template_name => "twitter_standard_search",
  	:settings      => {
  		:klass_name      => "Content",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
                    :cache_disabled   => true,
                    :version => 2,
      :old_widget      => true,
  		:kommands        => [
  		]
  	}
  },                
  {
  	:name          => "Default Ad Small Square",
  	:template_name => "v2_ad_template",
  	:settings      => {
  		:klass_name      => "Metadata",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
                    :use_post_button => false,
                    :cache_disabled => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "get_ad_slot",
          :args => ["small_square", "default"]
        }
  		]
  	}
  },
  {
  	:name          => "Default Ad Square",
  	:template_name => "v2_ad_template",
  	:settings      => {
  		:klass_name      => "Metadata",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
                    :use_post_button => false,
                    :cache_disabled => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "get_ad_slot",
          :args => ["square", "default"]
        }
  		]
  	}
  },
  {
  	:name          => "Default Ad Medium Rectangle",
  	:template_name => "v2_ad_template",
  	:settings      => {
  		:klass_name      => "Metadata",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
                    :use_post_button => false,
                    :cache_disabled => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "get_ad_slot",
          :args => ["medium_rectangle", "default"]
        }
  		]
  	}
  },
  {
  	:name          => "Default Ad Large Rectangle",
  	:template_name => "v2_ad_template",
  	:settings      => {
  		:klass_name      => "Metadata",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
                    :use_post_button => false,
                    :cache_disabled => true,
                    :version => 2,
  		:kommands        => [
  		  {
          :method_name => "get_ad_slot",
          :args => ["large_rectangle", "default"]
        }
  		]
  	}
  },
  {
  	:name          => "Default Ad Skyscraper",
  	:template_name => "v2_ad_template",
  	:settings      => {
  		:klass_name      => "Metadata",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
  		:kommands        => [
  		  {
          :method_name => "get_ad_slot",
          :args => ["skyscraper", "default"]
        }
  		]
  	}
  },
  {
  	:name          => "Default Ad Banner",
  	:template_name => "v2_ad_template",
  	:settings      => {
  		:klass_name      => "Metadata",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
  		:kommands        => [
  		  {
          :method_name => "get_ad_slot",
          :args => ["banner", "default"]
        }
  		]
  	}
  },
  {
  	:name          => "Default Ad Leaderboard",
  	:template_name => "v2_ad_template",
  	:settings      => {
  		:klass_name      => "Metadata",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
  		:kommands        => [
  		  {
          :method_name => "get_ad_slot",
          :args => ["leaderboard", "default"]
        }
  		]
  	}
  },
  {
  	:name          => "Double Column Triple Featured Items",
  	:template_name => "v2_double_col_triple_item",
  	:settings      => {
  		:klass_name      => "ViewObject",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
  		:kommands        => [
  		]
  	}
  },
  {
  	:name          => "Double Column Triple Popular Items",
  	:template_name => "v2_double_col_triple_item",
  	:settings      => {
  		:klass_name      => "ItemScore",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
                    :use_post_button => false,
                    :version => 5,
  		:kommands        => [
  		  {
                                       :method_name => "top_items",
                                       :args        => [3]
                                     }
  		]
  	}
  },
  {
  	:name          => "Double Column Featured With Triple Items",
  	:template_name => "v2_double_col_feature_triple_item",
  	:settings      => {
  		:klass_name      => "ViewObject",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
  		:kommands        => [
  		]
  	}
  },
  {
  	:name          => "Facebook Recommendations Plugin",
  	:template_name => "v2_single_facebook_widget",
  	:settings      => {
  		:klass_name      => "ViewObject",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
  		:use_post_button => false,
  		:kommands        => [
  		],
  		:meta            => {
  	    :template_type => "recommendations"
      }
  	}
  },
  {
  	:name          => "Facebook Activity Plugin",
  	:template_name => "v2_single_facebook_widget",
  	:settings      => {
  		:klass_name      => "ViewObject",
  		:locale_title    => nil,
  		:locale_subtitle => nil,
                    :use_post_button => false,
                    :version => 1,
  		:kommands        => [
  		],
  		:meta            => {
  	    :template_type        => "activity",
  	    :data_recommendations => false
      }
  	}
                },
                #
                # Automated items for default layout
                #
                  {
  	:name          => "Newest Universal Items",
  	:template_name => "v2_single_col_list_with_profile",
  	:settings      => {
  		:klass_name      => "ItemAction",
  		:locale_title    => "generic.newest_items.title",
  		:locale_subtitle => nil,
  		:use_post_button => false,
                    :css_class       => "active",
                    :version => 3,
  		:kommands        => [
  		  {
  		    :method_name => "newest_items",
          :args        => [5]
  		  }
  		]
  	}
  },
  {
  	:name          => "Double Column Triple Trending Stories",
  	:template_name => "v3_single_col_item_list",
  	:settings      => {
  		:klass_name      => "ItemScore",
  		:locale_title    => "generic.top_items.title",
  		:locale_subtitle => nil,
  		:use_post_button => false,
                    :css_class       => "active",
                    :version => 1,
  		:kommands        => [
  		  {
                                       :method_name => "top_items",
                                       :args => [5]
  		  }
  		]
  	}
  }
]
view_objects.each do |view_object_hash|
  view_object = ViewObject.where(:name => view_object_hash[:name]).first
  next if view_object and view_object.version == view_object_hash[:settings][:version]

  puts "Creating View Object: #{view_object_hash[:name]}--#{view_object_hash[:settings][:version] || 0}" if debug

  # Build ViewObject and Metadata::ViewObjectSetting
  view_object ||= ViewObject.new(:name => view_object_hash[:name])
  #view_object.build_setting
  view_object.setting ||= Metadata::ViewObjectSetting.new

  # reset kommands if we're updating the version
  if view_object.version != view_object_hash[:settings][:version]
    view_object.setting.kommands = []
  end

  # Set template
  view_object_template = ViewObjectTemplate.find_by_name(view_object_hash[:template_name])
  raise "Invalid Template Name" unless view_object_template
  view_object.view_object_template = view_object_template

  # Apply settings
  view_object.setting.view_object_name = view_object_hash[:name].parameterize.to_s
  view_object.setting.klass_name       = view_object_hash[:settings][:klass_name]
  view_object.setting.use_post_button  = view_object_hash[:settings][:use_post_button]
  view_object.setting.locale_title     = view_object_hash[:settings][:locale_title] if view_object_hash[:settings][:locale_title]
  view_object.setting.cache_disabled    = view_object_hash[:settings][:cache_disabled] if view_object_hash[:settings][:cache_disabled]
  view_object.setting.old_widget       = view_object_hash[:settings][:old_widget] if view_object_hash[:settings][:old_widget]
  view_object.setting.css_class        = view_object_hash[:settings][:css_class] if view_object_hash[:settings][:css_class]
  view_object.setting.locale_subtitle  = view_object_hash[:settings][:locale_subtitle] if view_object_hash[:settings][:locale_subtitle]
  view_object.setting.dataset          = view_object_hash[:settings][:dataset] if view_object_hash[:settings][:dataset]
  view_object.setting.meta             = view_object_hash[:settings][:meta] if view_object_hash[:settings][:meta]
  view_object.setting.version          = view_object_hash[:settings][:version] if view_object_hash[:settings][:version]

  # Add Kommands
  view_object_hash[:settings][:kommands].each do |kommand|
    params = {
      :args => kommand[:args] || [],
      :options => kommand[:options] || {},
      :method_name => kommand[:method_name]
    }
    view_object.setting.add_kommand(params)
  end

  # Make sure to save both the view object and the metadata setting
  if view_object.valid? and view_object.setting.valid?
    view_object.save!
    view_object.setting.save!
  else
    raise(view_object.errors.full_messages | view_object.setting.errors.full_messages).inspect
  end
end

home_view_object = ViewObject.find_or_create_by_name("home--index")
unless home_view_object.edge_children.any?
  ["Double Column Triple Trending Stories", "Newest Univeral Items", "Top Universal Items", "Newest Questions", "Newest Classifieds", "Default Ad Square", "Newest Gallery Double Column Small Strip", "Recent Users", "Welcome Panel"].each do |name|
    puts "Adding #{name}" if debug
    home_view_object.add_child! ViewObject.find_by_name(name)
  end
end


#######################################################################
# Menu Items
#######################################################################
menu_items = {
  :home => {
    :data => {
      :name          => "Home Page",
      :position      => 0,
      :resource_path => "home_index_path",
      :locale_string => "shared.page_tabs.home"
    }
  },
  :stories => {
    :data => {
      :name          => "Stories Page",
      :position      => 1,
      :resource_path => "stories_path",
      :locale_string => "shared.page_tabs.stories"
    },
    :children => {
      :stories_list => {
        :data => {
          :name          => "Stories Page",
          :position      => 1,
          :resource_path => "stories_path",
          :locale_string => "shared.page_tabs.stories_list"
        }
      },
      :newswires => {
        :data => {
          :name          => "Newswires Page",
          :position      => 2,
          :resource_path => "newswires_path",
          :locale_string => "shared.page_tabs.newswire"
        }
      },
      :new_story => {
        :data => {
          :name          => "New Story Page",
          :position      => 3,
          :resource_path => "new_story_path",
          :locale_string => "shared.page_tabs.new_story"
        }
      },
      :new_article => {
        :data => {
          :name          => "New Article Page",
          :position      => 4,
          :resource_path => "new_article_path",
          :locale_string => "shared.page_tabs.new_article",
          :enabled       => false
        }
      }
    }
  },
  :articles => {
    :data => {
      :name          => "Articles Page",
      :position      => 2,
      :resource_path => "articles_path",
      :locale_string => "shared.page_tabs.articles"
    },
    :children => {
      :articles_list => {
        :data => {
          :name          => "Articles Page",
          :position      => 1,
          :resource_path => "articles_path",
          :locale_string => "shared.page_tabs.articles_list"
        }
      },
      :users_list => {
        :data => {
          :name          => "Users Page",
          :position      => 2,
          :resource_path => "users_path",
          :locale_string => "shared.page_tabs.users_list"
        }
      },
      :new_article => {
        :data => {
          :name          => "New Article Page",
          :position      => 3,
          :resource_path => "new_article_path",
          :locale_string => "shared.page_tabs.new_article"
        }
      }
    }
  },
  :forums => {
    :data => {
      :name          => "Forums Page",
      :position      => 3,
      :resource_path => "forums_path",
      :locale_string => "shared.page_tabs.forums"
    }
  },
  :classifieds => {
    :data => {
      :name          => "Classifieds Page",
      :position      => 4,
      :resource_path => "classifieds_path",
      :locale_string => "shared.page_tabs.classifieds"
    },
    :children => {
      :classifieds_list => {
        :data => {
          :name          => "Classifieds Page",
          :position      => 1,
          :resource_path => "classifieds_path",
          :locale_string => "shared.page_tabs.classifieds_list"
        }
      },
      :new_classified => {
        :data => {
          :name          => "New Classified Page",
          :position      => 2,
          :resource_path => "new_classified_path",
          :locale_string => "shared.page_tabs.new_classified"
        }
      }
    }
  },
  :questions => {
    :data => {
      :name          => "Questions Page",
      :position      => 5,
      :resource_path => "questions_path",
      :locale_string => "shared.page_tabs.questions"
    },
    :children => {
      :questions_list => {
        :data => {
          :name          => "Questions Page",
          :position      => 1,
          :resource_path => "questions_path",
          :locale_string => "shared.page_tabs.questions_list"
        }
      },
      :my_questions_list => {
        :data => {
          :name          => "My Questions Page",
          :position      => 2,
          :resource_path => "my_questions_question_path",
          :locale_string => "questions.my_questions",
          :enabled       => false
        }
      },
      :new_question => {
        :data => {
          :name          => "New Question Page",
          :position      => 3,
          :resource_path => "new_question_path",
          :locale_string => "shared.page_tabs.new_question"
        }
      }
    }
  },
  :resources => {
    :data => {
      :name          => "Resources Page",
      :position      => 6,
      :resource_path => "resources_path",
      :locale_string => "shared.page_tabs.resources"
    },
    :children => {
      :resources_list => {
        :data => {
          :name          => "Resources Page",
          :position      => 1,
          :resource_path => "resources_path",
          :locale_string => "shared.page_tabs.resources_list"
        }
      },
      :new_resource => {
        :data => {
          :name          => "New Resource Page",
          :position      => 2,
          :resource_path => "new_resource_path",
          :locale_string => "shared.page_tabs.new_resource"
        }
      }
    }
  },
  :events => {
    :data => {
      :name          => "Events Page",
      :position      => 7,
      :resource_path => "events_path",
      :locale_string => "shared.page_tabs.events"
    },
    :children => {
      :events_list => {
        :data => {
          :name          => "Events Page",
          :position      => 1,
          :resource_path => "events_path",
          :locale_string => "shared.page_tabs.events_list"
        }
      },
      :my_events_list => {
        :data => {
          :name          => "My Events Page",
          :position      => 2,
          :resource_path => "my_events_event_path",
          :locale_string => "share.subnav.events_subnav.my_events",
          :enabled       => false
        }
      },
      :new_event => {
        :data => {
          :name          => "New Event Page",
          :position      => 3,
          :resource_path => "new_event_path",
          :locale_string => "shared.page_tabs.new_event"
        }
      }
    }
  },
  :galleries => {
    :data => {
      :name          => "Galleries Page",
      :position      => 8,
      :resource_path => "galleries_path",
      :locale_string => "shared.page_tabs.galleries"
    },
    :children => {
      :galleries_list => {
        :data => {
          :name          => "Galleries Page",
          :position      => 1,
          :resource_path => "galleries_path",
          :locale_string => "shared.page_tabs.galleries_list"
        }
      },
      :new_gallery => {
        :data => {
          :name          => "New Gallery Page",
          :position      => 2,
          :resource_path => "new_gallery_path",
          :locale_string => "shared.page_tabs.new_gallery"
        }
      }
    }
  },
  :ideas => {
    :data => {
      :name          => "Ideas Page",
      :position      => 9,
      :resource_path => "ideas_path",
      :locale_string => "shared.page_tabs.ideas"
    },
    :children => {
      :ideas_list => {
        :data => {
          :name          => "Ideas Page",
          :position      => 1,
          :resource_path => "ideas_path",
          :locale_string => "shared.page_tabs.ideas_list"
        }
      },
      :my_ideas_list => {
        :data => {
          :name          => "My Ideas Page",
          :position      => 2,
          :resource_path => "my_ideas_idea_path",
          :locale_string => "share.subnav.ideas_subnav.my_ideas",
          :enabled       => false
        }
      },
      :new_idea => {
        :data => {
          :name          => "New Idea Page",
          :position      => 3,
          :resource_path => "new_idea_path",
          :locale_string => "shared.page_tabs.new_idea"
        }
      }
    }
  },
  :predictions => {
    :data => {
      :name          => "Predictions Page",
      :position      => 10,
      :resource_path => "predictions_path",
      :locale_string => "shared.page_tabs.predictions"
    }
  },
  :cards => {
    :data => {
      :name          => "Cards Page",
      :position      => 11,
      :resource_path => "cards_path",
      :locale_string => "cards.menu_title"
    }
  }
}

menu_items.each do |name, menu_item_data|
  data = menu_item_data[:data]
  data[:name_slug] = name.to_s
  menu_item = MenuItem.find_or_create_by_name_slug(data)

  if menu_item_data[:children].present?
    menu_item_data[:children].each do |child_name, child_menu_item_data|
      child_data = child_menu_item_data[:data]
      child_data[:name_slug] = child_name.to_s
      child_data[:parent_id] = menu_item.id
      child_menu_item = MenuItem.find_or_create_by_name_slug(child_data)
    end
  end
end
