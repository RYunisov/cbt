#encoding: UTF-8
include SessionsHelper
class LogsController < ApplicationController
  
  before_filter :authenticate, :except => [:show, :new, :create, :forget]
  before_filter :check_signed, :only => [:create, :new]
  before_filter :correct_user, :only => [:index]
    
  def index
    @title = 'Логи'
    @user = User.find(params[:user_id])
    @log = @user.logs
  end

private 

  def authenticate
    deny_access unless signed_in?
  end

  def check_signed
    if signed_in?
      flash[:error] = "Вы уже зарегистрированы"
      redirect_to current_user
    end
  end

  def correct_user
    @user = User.find_by_id(params[:user_id])
    redirect_to @user  unless ( current_user?(@user) || current_user.admin? )  
  end  
end
