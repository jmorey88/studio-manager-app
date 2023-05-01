class PagesController < ApplicationController
  skip_before_action :authenticate, only: [:home, 
                                           :help]
  def home
  end

  def help
  end    
  
end
