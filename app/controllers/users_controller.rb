# encoding: utf-8
include SessionsHelper

class UsersController < ApplicationController
  
  before_filter :authenticate, :except => [:show, :new, :create, :forget]
  before_filter :check_signed, :only => [:create, :new]
  before_filter :correct_user, :only => [:edit, :update]

  def index
    if current_user.admin?
      @title = 'Управление'
      @user = current_user
      @users = User.all
    else
      redirect_to current_user
    end  
  end  

  def show
    if signed_in? 
       @user = User.find(params[:id])
#       Mailer.hello(@user).deliver
       if current_user?(@user) || current_user.admin?
         @title = @user.name
         @future = Future.all
       else
         flash[:error] = 'Это не ваш личный кабинет!'
         redirect_to current_user
       end
    else
      flash[:error] = 'Необходимо зарегистрироваться'
      redirect_to root_path
    end
  end

  def new
   @user = User.new(:invitation_token => params[:invitation_token])
   @user.mail = @user.invitation.recipient_email if @user.invitation
   @title = "Создание нового пользователя"
  end

  def create
   @user = User.new(params[:user])
     if @user.save
       sign_in @user
       flash[:success] = "Пользователь успешно добавлен"
       redirect_to @user
     else
       render 'new'
     end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:success] = "Данные пользователя обновлены"
      redirect_to @user
    else
      flash[:error] = 'Возникли проблемы при обновлении'
      render 'edit'
    end
  end  
  
  def pass_edit
    @user = User.find(params[:id])
  end

  def destroy
    
  end

private 

  def authenticate
    deny_access unless signed_in?
  end

  def check_signed
    if signed_in? && !current_user.admin?
      flash[:error] = "Вы уже зарегистрированы"
      redirect_to current_user
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(@user) unless current_user?(@user) || current_user.admin?
  end

end
