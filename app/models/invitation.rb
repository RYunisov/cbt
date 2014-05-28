#encoding: UTF-8
class Invitation < ActiveRecord::Base

  attr_accessible :recipient_email
  
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
  
  validates_presence_of :recipient_email
  validate :recipient_is_not_registered
  validate :sender_has_invitations, :if => :sender
  
  before_create :generate_token
  before_create :decrement_sender_count, :if => :sender
  
private 

  def generate_token 
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
  
  def sender_has_invitations
     unless sender.invitation_limit > 0
       errors.add_to_base 'У Вас больше нет пришлашений'
     end   
  end  
  
  def recipient_is_not_registered
     errors.add :recipient_email, "Пользователь с таким email уже существует" if User.find_by_mail(recipient_email)
  end
  
  def decrement_sender_count
    sender.decrement! :invitation_limit
  end  
end
