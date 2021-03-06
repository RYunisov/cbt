module SessionsHelper

def sign_in(user)
  cookies.permanent.signed[:remember_token] = [user.id, user.salt]
  self.current_user = user
end

def current_user=(user)
  @current_user = user
end

def current_user
  @current_user ||= user_from_remember_token
end

def subscriber_user?(user)
  @subs ||= subs_user_and_status(user)
end

def signed_in?
  !current_user.nil? 
end

def sign_out
  cookies.delete(:remember_token)
  self.current_user = nil
end
			
def current_user?(user)
 user == current_user
end

def deny_access
  store_location
  redirect_to signin_path, :notice => "Please sign in to access this page"
end

def redirect_back_or(default)
  redirect_to(session[:return_to] || default)
  clear_return_to
end

def current_city=(city_id)
  @current_city = city_id
end

def current_city
  @current_city ||= from_city
end

  private

    def subs_user_and_status(user)
      sub = Subscriber.where("user_id", user.id).first
      sub.nil? ? nil? : sub.status
    end
     
    def from_city
      cookies[:city_id].nil? ? nil : City.find_by_id(cookies[:city_id])
    end

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def user_create_product(id)
      User.find_by_id(id)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end
end
