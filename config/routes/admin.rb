N2::Application.routes.draw do
  namespace :admin do
    match '/block.:format' => 'misc#block', :as => :block
    match '/flag_item.:format' => 'misc#flag', :as => :flag_item
    match '/feature.:format' => 'misc#feature', :as => :feature
    match '/featured_items/:id/load_items/page/:page' => 'featured_items#load_items', :as => :feature
    match '/translations.:format' => 'translations#translations', :as => :translations
    match '/asset_translations.:format' => 'translations#asset_translations', :as => :asset_translations

    resource :branding, :controller => 'branding'

    resources :activity_scores
    resources :ad_layouts
    resources :ads
    resources :announcements
    resources :answers
    resources :cards
    resources :classifieds
    resources :comments
    resources :content_dashboard do
      collection do
        get :news_topics
        post :news_topics
        put :news_topics
      end
    end

    resources :content_images
    resources :contents

    resources :dashboard_messages do
      member do
        post :send_global
        get :send_global
        get :clear_global
        post :clear_global
      end
      collection do
        get :clear_global
        post :clear_global
      end
    end


    resources :events do
      collection do
        get :import_zvents
        post :import_zvents
      end
    end


    resources :featured_items do
      member do
        get :load_template
        post :load_template
        get :load_new_template
        post :load_new_template
        get :load_items
        post :load_items
      end
      collection do
        post :save
        get :new_featured_widgets
        post :save_featured_widgets
      end
    end

    resources :feeds do
      member do
        get :fetch_new
      end
    end
    resources :flags
    resources :forums do
      collection do
        get :reorder
        post :reorder
      end
    end
    resources :galleries
    resources :gallery_items
    resources :gos
    resources :idea_boards
    resources :ideas
    resources :images
    resources :locales do
      collection do
        get :refresh
      end
      resources :translations
    end

    resources :menu_items do
      collection do
        post :save
      end
    end

    resources :newswires
    resources :prediction_groups do
      member do
        get :approve
        post :approve
      end
    end
    resources :prediction_guesses
    resources :prediction_questions do
      member do
        get :approve
        post :approve
      end
    end

    resources :prediction_results do
      member do
        get :accept
        post :accept
      end
    end
    resources :prediction_scores do
      collection do
        get :refresh_all
        post :refresh_all
      end
    end
    resources :questions
    resources :related_items
    resources :resource_sections
    resources :resources
    resources :settings
    resources :setting_groups
    resources :skip_images
    resources :sources
    resources :sponsor_zones
    resources :title_filters
    resources :topics
    resources :tweet_streams do
      member do
        get :fetch_new_tweets
      end
    end

    resources :tweets
    resources :tweet_accounts
    resources :twitter_settings do
      collection do
        post :update_keys
        post :update_auth
        get :reset_keys
      end
    end
    resources :user_profiles,      :active_scaffold => true
    resources :users,           :active_scaffold => true
    resources :view_objects do
      member do
        get :edit_curated
        post :update_curated
        get :clone
      end
      collection do
        get :new_curated
        post :create_curated
      end
    end
    resources :view_object_templates
    resources :votes,           :active_scaffold => true

    resources :widgets do
      collection do
        post :save
        get :new_widgets
        get :newer_widgets
        post :save_newer_widgets
      end
    end

    namespace :metadata do
      resources :activity_scores
      resources :ad_layouts
      resources :ads
      resources :custom_widgets
      resources :settings
      resources :skip_images
      resources :sponsor_zones
      resources :title_filters
    end
  end

  match 'admin' => "admin#index"
end
