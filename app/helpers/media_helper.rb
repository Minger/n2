
module MediaHelper

  def default_image
    'skin/watermark.jpg'
  end

  def default_medium_image
    'skin/medium_watermark.jpg'
  end

  def external_thumb_image image
    base_url("/images/#{thumb_image_or_default(image)}")
  end
  
  def thumb_image_or_default image
    url = nil
    case image.class.name
      when String.name
        url = image
      when Gallery.name
        url = image.thumb_url
      when Image.name
        url = image.thumb_url
      when Video.name
        url = image.thumb_url
      when Classified.name
        url = image.images.first.try(:thumb_url)
      when Content.name
        url = image.images.first.try(:thumb_url)
      when Article.name
        url = image.content.images.first.try(:medium_url)
      when Resource.name
        url = image.images.first.try(:thumb_url)
      else
      	url = nil
    end
    if url.nil?
      if image.respond_to?(:images) and image.images.any?
        url = image.images.first.try(:thumb_url)
      end
    end
    url || default_image
  end

  def medium_image_or_default image
    url = nil
    case image.class.name
      when String.name
        url = image
      when Gallery.name
        url = image.medium_url
      when Image.name
        url = image.medium_url
      when Video.name
        url = image.medium_url
      when Classified.name
        url = image.images.first.try(:medium_url)
      when Content.name
        url = image.images.first.try(:medium_url)
      when Article.name
        url = image.content.images.first.try(:medium_url)
      when Resource.name
        url = image.images.first.try(:medium_url)
      else
      	url = nil
    end
    if url.nil?
      if image.respond_to?(:images) and image.images.any?
        url = image.images.first.try(:medium_url)
      end
    end
    url || default_medium_image
  end
  
end
