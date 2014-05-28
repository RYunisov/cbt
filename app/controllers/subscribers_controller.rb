# encoding: utf-8
class SubscribersController < ApplicationController
  def new
    @subscriber = Subscriber.new()
  end

  def create
   	if !params[:subscriber][:method].empty? && params[:subscriber][:time_id]
        current_user.follow!(params[:subscriber])
        flash[:notice] = 'Подписка успешно добавлена'
        redirect_to current_user  
    else
      flash[:error] = 'Ошибка при добавлении подписки'
      redirect_to current_user
    end
  end

  def edit
     @sub = Subscriber.where(:user_id => params[:user_id]).first
  end

  def update
    @sub = Subscriber.where(:user_id => current_user.id).first
    if @sub.update_attributes(params[:subscriber])
     flash[:error] = "Subscriber update"
     redirect_to current_user
    end
  end

  def destroy
    @user = Subscriber.find(params[:id]).user
    Subscriber.find(params[:id]).destroy
    #Subscriber.where('user_id = ? AND future_id = ?', @user.id, params[:subscriber][:future_id]).destroy_all
    flash[:notice] = "Подписка удалена"
    redirect_to @user
  end
end
