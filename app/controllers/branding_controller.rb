class BrandingController < ActionController::Base
  def logo
    send_file(Branding.logo)
  end

  def favicon
    send_file(Branding.favicon)
  end

  private

  def send_file data
    if data.present?
      send_data(data, :disposition => 'inline', :content_type => 'image/png')
    end
  end
end
