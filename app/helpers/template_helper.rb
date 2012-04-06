module TemplateHelper

  def panel size = 1, &block
    content_tag(:div, capture(&block), :class => "panel-#{size}")
  end
  def panel1(&block) panel(1, &block) end
  def panel2(&block) panel(2, &block) end
  def panel3(&block) panel(3, &block) end

  def panel_bar(title = nil, extra_options = {}, &block)
    options = {
      :title_tag => :h2
    }.merge(extra_options)

    content_tag(:div, :class => "panel-bar") do
      if block_given?
        capture(&block)
      else
        content_tag(options[:title_tag], title)
      end
    end
  end

  def feature_panel extra_class = nil, &block
    css_class = ['feature-panel', extra_class].compact.join(' ')
    content_tag(:div, capture(&block), :class => css_class)
  end
  def xlarge_feature_panel(&block) feature_panel('xlarge', &block) end
  def large_feature_panel(&block) feature_panel('large', &block) end
  def medium_feature_panel(&block) feature_panel('medium', &block) end
  def small_feature_panel(&block) feature_panel('small', &block) end

  def featured_item_block extra_options = {}, &block
    options = {
      :description => false,
      :title_tag   => :h3,
      :type        => 'wrap-small',
      :class       => nil
    }.merge extra_options

    class_string = ["feature-item-#{options[:type]}", options[:class] ].compact.join(" ")

    content_tag(:div, capture(&block), :class => class_string)
  end

  def small_featured_item_block options = {}, &block
    options.merge!({:type => 'wrap-small'})

    featured_item_block options, &block
  end

  def medium_featured_item_block options = {}, &block
    options.merge!({:type => 'medium'})

    featured_item_block options, &block
  end

  def xlarge_featured_item_block options = {}, &block
    options.merge!({
                     :type        => 'xlarge',
                     :title_tag   => :h2,
                     :description => true
                   })

    featured_item_block options, &block
  end

  def large_featured_item_block options = {}, &block
    options.merge!({
                     :type        => 'large',
                     :title_tag   => :h2,
                     :description => true
                   })

    featured_item_block options, &block
  end

  def featured_item item, extra_options = {}
    options = {
      :description => false,
      :title_tag   => :h3,
      :type        => 'small',
      :class       => nil
    }.merge extra_options

    class_string = ["feature-item-#{options[:type]}", options[:class] ].compact.join(" ")

    content_tag(:div, :class => class_string) do
      content = content_tag(:a, nil, :class => "overlay-link", :href => polymorphic_url(item.item_link))
      content << image_tag(medium_image_or_default(item))
      content << content_tag(:div, :class => "feature-caption") do
        nested_content = content_tag(options[:title_tag], link_to(item.item_title, item.item_link))
        if options[:description]
          nested_content << content_tag(:p, item.item_description[0,100])
        end
        nested_content
      end
      content
    end
  end

  def small_featured_item item, options = {}, &block
    options.merge!({:type => 'small'})

    featured_item item, options, &block
  end

  def medium_featured_item item, options = {}, &block
    options.merge!({:type => 'medium'})

    featured_item item, options, &block
  end

  def xlarge_featured_item item, options = {}, &block
    options.merge!({
                     :type        => 'xlarge',
                     :title_tag   => :h2,
                     :description => true
                   })

    featured_item item, options, &block
  end

  def large_featured_item item, options = {}, &block
    options.merge!({
                     :type        => 'large',
                     :title_tag   => :h2,
                     :description => false # TODO:: add this back in when suitable description truncate method found
                   })

    featured_item item, options, &block
  end

  def featured_item_list items, extra_options = {}, &block
    options = {
      :title_tag => :h4,
      :class     => nil,
      :title     => nil,
      :panel_bar => true
    }.merge(extra_options)

    content_tag(:div, :class => "item-list-wrap") do
      content_tag(:div, :class => "item-list") do
        content_tag(:ul) do
          last = items.pop
          content = items.map {|i| featured_item_list_item(i) }
          content.push featured_item_list_item(last, :class => 'last') if last
          content.join.html_safe
        end
      end
    end
  end

  def featured_item_list_item item, extra_options = {}
    options = {
      :class => nil,
      :title_tag => :h4
    }.merge(extra_options)

    content_tag(:li, :class => options[:class]) do
      content = content_tag(options[:title_tag], link_to(item.item_title, item.item_link))
      content << content_tag(:p, item.item_description[0,100]) if options[:item_description]
      content << content_tag(:h6, posted_by_with_date_and_topic(item)) unless options[:profile_disabled]
      content
    end
  end

  def double_col_item_list items, extra_options = {}, &block
    options = {
      :title_tag => :h3,
      :class     => nil,
      :title     => nil,
      :panel_bar => true,
      :raw => false
    }.merge(extra_options)

    content_tag(:div, :class => "item-list-wrap") do
      content_tag(:div, :class => "item-list") do
        content_tag(:ul) do
          content = items.map {|i| double_col_item_list_item(i, options) }
          content.join.html_safe
        end
      end
    end
  end

  def double_col_item_list_item item, extra_options = {}
    options = {
      :class => nil,
      :title_tag => :h3,
      :raw => false
    }.merge(extra_options)

    content_tag(:li, :class => options[:class]) do
      content_tag(:div, :class => 'item-image') do
        item_image_content = content_tag(:div, link_to(image_tag(medium_image_or_default(item)), item.item_link), :class => 'thumb')
        item_image_content << content_tag(:div, :class => 'content') do
          description = (options[:raw] || item.is_a?(Article)) ? raw(item.item_description) : item.item_description # yuck...
          content = content_tag(options[:title_tag], link_to(item.item_title, item.item_link))
          content << content_tag(:p, description[0,100])
          content << item_meta_profile(item)
        end
      end
    end
  end

  def item_meta_profile item, extra_options = {}, &block
    options = {
      :posted_by_tag => :h6,
      :posted_by_tag => :h6,
      :class         => nil,
      :extra_info    => true
    }.merge(extra_options)

    content_tag(:div, :class => 'meta-profile') do
      content = content_tag(:div, local_linked_profile_pic(item.item_user), :class => 'profile-pic')
      content << content_tag(:h6, generic_posted_by(item))
      # TODO add extra comment items
      content
    end
  end

  def single_featured_item item, extra_options = {}, &block
    content_tag(:div, :class => 'single-item-wrap') do
      content = content_tag(:h2, link_to(item.item_title, item.item_link))
      content << item_meta_profile(item)
    end
  end

end
