module LayoutHelper

  def page_meta_tags
    return nil unless get_current_meta_item or get_current_meta_klass
    if item = get_current_meta_item

      metas = [
               ["og:title", item.item_title],
               ["og:type", "article"],
               ["og:url", base_url(polymorphic_path(item.item_link))],
               ["og:image", external_thumb_image(item)],
               ["og:site_name", get_setting_value('site_title')],
               ["og:description", caption(strip_tags(item.item_description),250)]
              ]
    elsif klass = get_current_meta_klass
      metas = [
               ["og:title", klass_title(klass)],
               ["og:type", "article"],
               ["og:url", (path_to_klass(klass))],
               ["og:image", external_thumb_image(klass)],
               ["og:site_name", get_setting_value('site_title')],
               ["og:description", caption(strip_tags(klass_description(klass)),250)]
              ]
    else
      return nil
    end

    if APP_CONFIG['omniauth']['providers'] and APP_CONFIG['omniauth']['providers']['facebook']
      metas << ["fb:app_id", APP_CONFIG['omniauth']['providers']['facebook']['key']]
    end
    metas.map {|m| meta_tag(*m) }.join("\n").html_safe
  end

  def meta_tag tag, content
    content_tag(:meta, nil, :property => tag, :content => content)
  end

  def icon_fan_app_location
    'skin/icon-fan-app.gif'
  end

  def icon_fan_app_url
    if Branding.favicon
      favicon_branding_url
    else
      base_url(path_to_image(icon_fan_app_location))
    end
  end

  def item_page_title item
    page_title :item => item
  end

  def klass_page_title klass
    page_title :klass => klass
  end

  def text_page_title text
    content_for(:title, text)
  end

  def get_json_app_config
    {
      :invite_friends      => I18n.translate("invite_users_title"),
      :invite_users_detail => I18n.translate("invite_users_detail"),
      :invite_users_button  => I18n.translate("invite_users_button"),
      :invite_users_message => I18n.translate("invite_users_message")
    }.to_json
  end

  def s3_sitemap_enabled?
    File.exist?(File.join(Rails.root, "config", "s3.yml"))
  end

  def s3_sitemap_url
    return nil unless s3_sitemap_enabled?
    s3_config = YAML.load_file(File.join(Rails.root, "config", "s3.yml"))[Rails.env]

    "http://s3.amazonaws.com/#{s3_config['bucket']}/sitemaps/sitemap1.xml.gz"
  end

  def link_to_menu_item menu_item, current_tab = nil
    link_to t(menu_item.locale_string), send(menu_item.resource_path), :class => tab_selected?(current_tab, menu_item.name_slug)
  end
end
