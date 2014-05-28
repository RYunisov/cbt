class Future < ActiveRecord::Base
  attr_accessible :name, :valuenew, :valueold

  has_many :subscribers
end
