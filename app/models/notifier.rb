class Notifier < ActionMailer::Base
  helper :application
  #todo       from          "\"#{Metadata::Setting.find_setting('site_title').value}\" <#{message[:email]}>"

  def contact_us_message(message)
    subject       "Contact Us: #{message.subject}"
    from          message[:email]
    recipients    APP_CONFIG['contact_us_recipients']
    sent_on       Time.now
    body          :message => message
    content_type  "text/html"
  end

  def comment_message(message)
    subject       I18n.translate('message.commented_on', :name => message[:originator].name, :title => message[:participant].commentable.item_title, :site_title => Metadata::Setting.get_setting('site_title').value)
    from          message[:email]
    recipients    message[:recipients]
    sent_on       Time.now
    body          :message => message
    content_type  "text/html"
  end

  def answer_message(message)
    subject       I18n.translate('message.answered', :name => message[:originator].name, :title => message[:participant].item_title, :site_title => Metadata::Setting.get_setting('site_title').value)
    from          message[:email]
    recipients    message[:recipients]
    sent_on       Time.now
    body          :message => message
    content_type  "text/html"
  end

  def dashboard_message_message(message)
    subject       I18n.translate('message.dashboard_message', :name => message[:originator].name, :title => message[:participant].item_title, :site_title => Metadata::Setting.get_setting('site_title').value)
    from          message[:email]
    recipients    message[:recipients]
    sent_on       Time.now
    body          :message => message
    content_type  "text/html"
  end

  def topic_message(message)
    subject       I18n.translate('message.topic', :name => message[:originator].name, :title => message[:participant].item_title, :site_title => Metadata::Setting.get_setting('site_title').value)
    from          message[:email]
    recipients    message[:recipients]
    sent_on       Time.now
    body          :message => message
    content_type  "text/html"
  end
end
