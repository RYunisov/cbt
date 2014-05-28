#encoding: UTF-8
class User < ActiveRecord::Base
 
 attr_accessor :password, :password_confirmation
 attr_accessible :name, :mail, :phone, :count_sms, :password, :password_confirmation, :invitation_token, :comment

 has_many :subscribers, :dependent => :destroy
 has_many :logs
 has_many :sent_invitation, :class_name => 'Invitation', :foreign_key => 'sender_id'
 belongs_to :invitation

 validates :password, :presence => true,
                      :length => {:within => 6..40},
                      :confirmation => true,
                      :if => :password_changed?

 validates :mail,  :presence => true, 
                   :length => { :minimum => 3, :maximum => 254 },
                   :uniqueness => true,
                   :format => {:with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}

 validates :phone, :presence => true,
                   :length => { :minimum => 9, :maximum => 10 },
                   :uniqueness => true,
                   :format => {:with => /\d+/}
 
 validates :name, :presence => true,
                  :length => { :maximum => 50 }                   
                  
 validates :invitation_id, :presence => { :message => "Не правильное приглашение" },
                           :uniqueness => true,
                           :on => :create

 before_save :encrypt_password, :if =>  :password_changed?

 before_create :set_invitation_limit
 before_create :set_count_sms

 def has_password?(submitted_password)
   encrypted_password == encrypt(submitted_password)
 end

 def invitation_token 
   invitation.token if invitation
 end
 
 def invitation_token=(token)
   self.invitation = Invitation.find_by_token(token)
 end   

 def self.authenticate(email, submitted_password)
   #user = find_by_email(email)
   user = where(['mail = ?', email]).first
   user && user.has_password?(submitted_password) ? user : nil
 end

 def self.authenticate_with_salt(id, cookie_salt)
   user = find_by_id(id)
   (user && user.salt == cookie_salt) ? user : nil
 end

 def following?(future_id)
   #  subscribers.find_by_user_id(followed)
   #  subscribers.where("user_id = ? AND future_id = ?", followed.id, future_id) 
   subscribers.where("future_id = ?", future_id) 
 end

 def follow!(followed)
   subscribers.create!(followed)
 end

 def unfollow!(followed)
   #   subscribers.find_by_user_id(followed.id).destroy
   #   subscribers.where("user_id = ? AND future_id = ?", followed.id, future.id).destroy
   subscribers.find(followed).destroy
 end

 def password_changed?
   !@password.blank? #or encrypt_password.blank?
 end

private

 def set_count_sms
   self.count_sms = 10
 end

 def set_invitation_limit
   self.invitation_limit  = 3
 end

 def encrypt_password
   self.salt = make_salt if new_record?
   self.encrypted_password = encrypt(password)
 end

 def encrypt(string)
   secure_hash("#{salt}--#{string}")
 end

 def make_salt
   secure_hash("#{Time.now.utc}--#{password}")
 end

 def secure_hash(string)
   Digest::SHA2.hexdigest(string)
 end

end
