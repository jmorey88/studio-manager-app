# frozen_string_literal: true

# This controller is for Static Pages actions
class PagesController < ApplicationController
  skip_before_action :authenticate, only: %i[home
                                             help]
  def home; end

  def help; end
end
