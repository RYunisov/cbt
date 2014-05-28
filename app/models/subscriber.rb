class Subscriber < ActiveRecord::Base

   attr_accessible :status, :user_id, :time_id, :future_id, :method
   belongs_to :user
   has_many :futures

   validates :time_id, :method, :presence => true;

end
