module SubscribersHelper

  def time_id(u_id, f_id)
    hash = {1 => '15min', 2 => '30min', 3 => '45min', 4=> '60min'}
  	index = User.find(u_id).subscribers.find_by_future_id(f_id).time_id
  	return hash[index]
  end

  def method_id(u_id, f_id)
  	hash = {1 => 'email', 2 => 'phone'}
  	index = User.find(u_id).subscribers.find_by_future_id(f_id).method
  	#index = Subscriber.find_by_future_id(id).method
  	return hash[index]
  end

end
