class IdeasController < ApplicationController
  before_filter :logged_in_to_facebook_and_app_authorized, :only => [:new, :create, :update, :my_ideas], :if => :request_comes_from_facebook?

  cache_sweeper :idea_sweeper, :only => [:create, :update, :destroy]

  before_filter :set_current_tab
  before_filter :set_ad_layout, :only => [:index, :show, :my_ideas]
  before_filter :set_idea_board

  access_control do
    allow all, :to => [:index, :show, :tags]
    # HACK:: use current_user.is_admin? rather than current_user.has_role?(:admin)
    # FIXME:: get admins switched over to using :admin role
    allow :admin, :of => :current_user
    allow :admin
    allow logged_in, :to => [:new, :create, :my_ideas]
    #allow :owner, :of => :model_klass, :to => [:edit, :update]
  end

  def index
    @page = params[:page].present? ? (params[:page].to_i < 3 ? "page_#{params[:page]}_" : "") : "page_1_"
    @current_sub_tab = 'Browse Ideas'
    @ideas = Idea.active.paginate :page => params[:page], :per_page => Idea.per_page, :order => "created_at desc"
    set_sponsor_zone('ideas')
    respond_to do |format|
      format.html { @paginate = true }
      format.atom
      format.json { @ideas = Idea.refine(params) }
    end
  end

  def new
    @current_sub_tab = 'Suggest Idea'
    @idea = Idea.new
    @idea.idea_board = @idea_board if @idea_board.present?
    @ideas = Idea.active.newest
  end

  def create
    @idea = Idea.new(params[:idea])
    @idea.tag_list = params[:idea][:tags_string]
    @idea.user = current_user
    if params[:idea][:idea_board_id].present?
    	@idea_board = IdeaBoard.active.find_by_id(params[:idea][:idea_board_id])
    	@idea.section_list = @idea_board.section unless @idea_board.nil?
    end

    if @idea.valid? and current_user.ideas.push @idea
      if @idea.post_wall?
        session[:post_wall] = @idea
      end      
      if get_setting('tweet_all_moderator_items').try(:value)
        if current_user.present? and current_user.is_moderator?
          @idea.tweet
        end
      end
    	flash[:success] = "Thank you for your idea!"
    	redirect_to @idea_board.present? ? [@idea_board, @idea] : @idea
    else
      @ideas = Idea.active.newest
    	render :new
    end
  end

  def show
    @idea = Idea.active.find(params[:id])
    tag_cloud @idea
    set_outbrain_item @idea
    set_sponsor_zone('ideas', @idea.item_title.underscore)
    set_current_meta_item @idea
  end

  def my_ideas
    @paginate = true
    @current_sub_tab = 'My Ideas'
    @user = User.active.find(params[:id])
    @ideas = @user.ideas.active.paginate :page => params[:page], :per_page => Idea.per_page, :order => "created_at desc"
  end

  def tags
    tag_name = CGI.unescape(params[:tag])
    @paginate = true
    @ideas = Idea.active.tagged_with(tag_name, :on => 'tags').paginate :page => params[:page], :per_page => 20, :order => "created_at desc"
    render :template => 'ideas/index'
  end

  private

  def set_idea_board
    @idea_board = params[:idea_board_id].present? ? IdeaBoard.active.find(params[:idea_board_id]) : nil
  end

  def set_current_tab
    @current_tab = 'ideas'
  end

end
