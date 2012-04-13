class Branding < ActiveRecord::Base
  def self.logo
    main.logo
  end

  def self.favicon
    main.favicon
  end

  def self.main
    Branding.first || Branding.create!
  end
end
