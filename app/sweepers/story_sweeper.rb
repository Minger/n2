class StorySweeper < ActionController::Caching::Sweeper
  observe Content, Comment, Vote, Article

  def after_save(record)
    if record.is_a?(Content)
    	story = record
    	StorySweeper.expire_story_all story
    elsif record.is_a?(Article)
    	StorySweeper.expire_article_all record
    	clear_article_cache(record)
    	story = record.content
    elsif record.is_a?(Comment) and record.commentable.is_a?(Content)
      story = record.commentable
    elsif record.is_a?(Vote) and record.voteable.is_a?(Content)
      story = record.voteable
    else
    	story = false
    end

    clear_story_cache(story) if story
  end

  def after_destroy(record)
    if record.is_a?(Content)
    	story = record
    elsif record.is_a?(Comment)
      story = record.content
    elsif record.is_a?(Vote) and record.voteable.is_a?(Content)
      story = record.voteable
    else
    	story = false
    end

    clear_story_cache(story) if story
  end

  def clear_story_cache(story)
    ['stories_short','top_stories', 'active_users', 'most_discussed_stories', 'top_users', 'top_ideas', 'top_events', 'featured_items', 'newest_users', 'newest_ideas', 'header', 'fan_application', 'prompt_permissions', "#{story.cache_key}_top", "#{story.cache_key}_bottom", "#{story.cache_key}_sidebar", "#{story.cache_key}_who_liked", "top_Content_tags", "top_Content_sections"].each do |fragment|
      expire_fragment "#{fragment}_html"
    end
    ['', 'page_1_', 'page_2_'].each do |page|
      expire_fragment "stories_list_#{page}html"
    end
    #expire_page root_path
    NewscloudSweeper.expire_instance(story)
  end

  def clear_article_cache article
    ['blog_roll','newest_articles', 'top_articles', 'articles_as_blog'].each do |fragment|
      expire_fragment "#{fragment}_html"
    end
  end

  def self.expire_story_all story
    controller = ActionController::Base.new
    ['top_stories', 'stories_list', 'featured_items', 'most_discussed_stories', "#{story.cache_key}_top", "#{story.cache_key}_bottom", "#{story.cache_key}_sidebar", "top_Content_tags", "top_Content_sections", 'newest_stories', 'auto_feature_sidebar', 'auto_feature_mini', 'auto_feature' ].each do |fragment|
      controller.expire_fragment "#{fragment}_html"
    end
    ['', 'page_1_', 'page_2_'].each do |page|
      controller.expire_fragment "stories_list_#{page}html"
    end

    StorySweeper.expire_article_all story.article if story.is_article?
    NewscloudSweeper.expire_instance(story)
  end

  def self.expire_article_all article
    controller = ActionController::Base.new
    ['blog_roll','newest_articles', 'top_articles', 'articles_as_blog'].each do |fragment|
      controller.expire_fragment "#{fragment}_html"
    end
    ['', 'page_1_', 'page_2_'].each do |page|
      controller.expire_fragment "articles_list_#{page}html"
    end
    NewscloudSweeper.expire_instance(article)
  end

end
