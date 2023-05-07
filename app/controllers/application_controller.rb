# frozen_string_literal: true

# This controller is for Application actions
class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :authenticate

  def authenticate
    return if current_user

    flash[:error] = 'Log in to view this page.'
    redirect_to root_path
  end
end
