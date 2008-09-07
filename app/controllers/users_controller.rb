class UsersController < ApplicationController

  def index
    if session[:user_id]
      redirect_to :controller => "admin"
    else
      if request.post? and params[:user]
        @user = User.new(params[:user])
        user = User.find_by_name_and_password(@user.name,@user.password)
        if user
          session[:user_id] = user.id
          if user.active != 0
            redirect_to :controller => ""
          else
             @user.password = nil
             flash[:notice] = "Sorry, but your account has been disabled. Please contact an administrator for further help!"
          end
        else
          #Don't show the password in the view
          @user.password = nil
          flash[:notice] = "Invalid user or password combination!"
        end
      end
    end  
  end

  def add
    if request.post? && params[:user]
      @user = User.new(params[:user])
      if @user.password == @user.confirm_password
        @user.save
        redirect_to :action => "list"
      else
        @user.clear_password!
        flash[:notice] = "Sorry, but your passwords did not match, please try again."
      end  
    else
      flash[:notice] = "Here you can add a user to the system."
    end  
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def remove
    if params[:user_id]
      @user = User.find_by_id(params[:user_id])
      @user.destroy
      flash[:notice] = "User has been removed from the system."
      redirect_to :action => 'list'
    else
      redirect_to :action => 'list'
    end  
  end

  def list
    @users = User.find(:all)
  end
  
  def logout
    session[:user_id] = nil
    redirect_to :controller => "users" 
  end  
end
