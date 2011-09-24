class PredictionQuestionsController < ApplicationController
  before_filter :login_required, :only => [:new, :create]
  after_filter :store_location, :only => [:new, :create, :show ]
  cache_sweeper :prediction_sweeper, :only => [:create, :update, :destroy]
  
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
   @current_sub_tab = 'New Prediction Question'
   @prediction_question = PredictionQuestion.new
  end

  def create
    @prediction_question = PredictionQuestion.new(params[:prediction_question])
    @prediction_question.tag_list = params[:prediction_question][:tags_string]
    @prediction_question.user = current_user
    @prediction_question.is_approved = current_user.is_moderator?      
    if params[:prediction_question][:prediction_group_id].present?
    	@prediction_group = PredictionGroup.active.find_by_id(params[:prediction_question][:prediction_group_id])
    	@prediction_question.prediction_group = @prediction_group unless @prediction_group.nil?
    end

    if @prediction_question.valid? and current_user.prediction_questions.push @prediction_question
    	flash[:success] = t('predictions.new.create_prediction_question')
    	redirect_to @prediction_question
    else
    	flash[:error] = "Could not create your question, please clear the errors and try again."
    	render :new
    end
  end  

  def show
    @prediction_question = PredictionQuestion.active.find(params[:id])
    tag_cloud(@prediction_question)
  end

  def tags
    tag_name = CGI.unescape(params[:tag])
    @paginate = true
    @prediction_questions = PredictionQuestion.active.tagged_with(tag_name, :on => 'tags').paginate :page => params[:page], :per_page => 20, :order => "created_at desc"
  end
  
end
