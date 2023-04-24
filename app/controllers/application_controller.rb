class ApplicationController < ActionController::Base
  include ApplicationHelper
  def authenticate
    unless current_user 
      flash[:error] = "Log in to view this page"
      redirect_to root_path
    end
  end


end
