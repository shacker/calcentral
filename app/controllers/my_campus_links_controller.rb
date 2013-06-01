class MyCampusLinksController < ApplicationController

  def get_feed
    if session[:user_id]
      render :json => MyCampusLinks.new(session[:user_id], :original_user_id => session[:original_user_id]).get_feed.to_json
    else
      render :json => {}.to_json
    end
  end

end
