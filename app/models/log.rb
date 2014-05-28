class Log < ActiveRecord::Base

  attr_accessible :text, :method_id, :user_id

  belongs_to :user
  
  default_scope order('created_at DESC')
end
