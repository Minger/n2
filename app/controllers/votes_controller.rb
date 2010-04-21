class VotesController < ApplicationController
  cache_sweeper :vote_sweeper, :only => [:like, :dislike]

  before_filter :login_required, :only => [:like, :dislike]

  def like
    @voteable = find_voteable
    respond_to do |format|
      error = (current_user and current_user.voted_for?(@voteable)) ? "You already voted" : false
      if !error and current_user and @voteable.present? and current_user.vote_for(@voteable)
      	success = "Thanks for your vote!"
      	format.html { flash[:success] = success; redirect_to params[:return_to] || @voteable }
      	format.fbml { flash[:success] = success; redirect_to params[:return_to] || @voteable }
      	format.json { render :json => { :msg => "#{@voteable.votes_tally} likes" }.to_json }
      	format.fbjs { render :json => { :msg => "#{@voteable.votes_tally} likes" }.to_json }
      else
      	error ||= "Vote failed"
      	format.html { flash[:error] = error; redirect_to params[:return_to] || @voteable }
      	format.fbml { flash[:error] = error; redirect_to params[:return_to] || @voteable }
      	format.json { render :json => { :msg => error }.to_json }
      	format.fbjs { render :text => { :msg => error }.to_json }
      end
    end
  end

  def dislike
    @voteable = find_voteable
    respond_to do |format|
      if current_user and @voteable.present? and current_user.vote_against(@voteable)
      	success = "Thanks for your vote!"
      	format.html { flash[:success] = success; redirect_to params[:return_to] || @voteable }
      	format.fbml { flash[:success] = success; redirect_to params[:return_to] || @voteable }
      	format.json { render :json => { :msg => "#{@voteable.votes_tally} likes" }.to_json }
      	format.fbjs { render :json => { :msg => "#{@voteable.votes_tally} likes" }.to_json }
      else
      	error = "Vote failed"
      	format.html { flash[:error] = error; redirect_to params[:return_to] || @voteable }
      	format.fbml { flash[:error] = error; redirect_to params[:return_to] || @voteable }
      	format.json { render :json => { :msg => error }.to_json }
      	format.fbjs { render :text => { :msg => error }.to_json }
      end
    end
  end

  private

  def find_voteable
    params.each do |name, value|
      next if name =~ /^fb/
      if name =~ /(.+)_id$/
        # switch story requests to use the content model
        klass = $1 == 'story' ? 'content' : $1
        return klass.classify.constantize.find(value)
      end
    end
    nil
  end

end
