#encoding: UTF-8
include SessionsHelper
class SessionsController < ApplicationController
  
  before_filter :check_authorization, :only => [:new]
  
  def new
    @title = 'Sign In'
    render 'pages/login'
  end
  
  def create
   user = User.authenticate(params[:session][:email], params[:session][:password])
   
   if user.nil?
     flash[:error] = "Error email/password"
     render 'pages/login'
   else
     sign_in user
     redirect_back_or user
   end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
  
  private 
  
  def check_signed
    if signed_in?
      flash[:error] = "Вы уже зарегистрированы"
      redirect_to current_user
    end
  end
  
  def check_authorization
      redirect_to current_user if signed_in?
  end  
end
