class Admin::BrandingController < AdminController
  before_filter :set_current_tab

  def create
    if params[:logo]
      Branding.main.update_attribute(:logo, params[:logo].read)
    end
    if params[:favicon]
      Branding.main.update_attribute(:favicon, params[:favicon].read)
    end
    flash[:notice] = "Updated!"
    redirect_to :action => 'show'
  end

  def show
  end

  private

  def set_current_tab
    @current_tab = 'settings'
  end

end
