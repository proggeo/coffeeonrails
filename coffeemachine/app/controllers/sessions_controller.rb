class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :require_admin, only: [:new, :create, :destroy]

  def new
  end

  def create
    puts params
    puts params[:password]
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
