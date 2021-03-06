class TopicsController < ApplicationController
  before_filter :find_forum
  before_filter :set_meta_klass, :only => [:index]

  access_control do
    allow all, :to => [:index, :show, :tags]
    # HACK:: use current_user.is_admin? rather than current_user.has_role?(:admin)
    # FIXME:: get admins switched over to using :admin role
    allow :admin, :of => :current_user
    allow :admin
    allow logged_in, :to => [:new, :create]
    #allow :owner, :of => :model_klass, :to => [:edit, :update]
  end

  def new
    @topic = @forum.topics.new
  end

  def show
    @topic = @forum.topics.find(params[:id])
    @topic.viewed!
    tag_cloud @topic
    set_outbrain_item @topic
    set_current_meta_item @topic
  end

  def create
    success = false
    @topic = @forum.topics.build(params[:topic])
    @topic.tag_list = params[:topic][:tags_string]

    @topic.transaction do
      @topic.user = current_user
      @post = @topic.posts.build({:comments => @topic.body, :user => current_user})
      @post.commentable = @topic
      success = (@topic.valid? and current_user.topics.push @topic)
    end

    if success
      ForumSweeper.expire_topic_all @topic

      if @topic.post_wall?
        session[:post_wall] = @topic
      end
      flash[:success] = "Successfully posted your new topic!"
      redirect_to [@forum, @topic]
    else
      render :new
    end
  end

  def tags
    @tag_name = CGI.unescape(params[:tag])
    @paginate = true
    @topics = @forum.topics.tagged_with(@tag_name, :on => 'tags').active.paginate :page => params[:page], :per_page => 20, :order => "created_at desc"
  end

  private

  def find_forum
    if params[:forum_id]
      @forum = Forum.active.find(params[:forum_id])
    elsif params[:id]
      @topic = Topic.active.find(params[:id])
      redirect_to forum_topic_path(@topic.forum, @topic)
    else
      redirect_to forums_path
    end
  end

  def set_current_tab
    @current_tab = 'forums'
  end

  def set_meta_klass
    set_current_meta_klass Topic
  end

end
