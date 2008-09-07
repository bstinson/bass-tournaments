class AdminController < ApplicationController
  before_filter :protect
  def index
    
  end  
    
protected
    def protect
      if session[:user_id].nil?
        redirect_to :controller => "users"
        return false
      end
    end
end
