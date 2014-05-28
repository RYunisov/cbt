#encoding: UTF-8
class Mailer < ActionMailer::Base  
  default from: "CoffeeBreak <no-reply@cb-t.ru>"
  def invitation(invitation, signup_url)
  	@invitation = invitation
  	@signup_url = signup_url
    mail( :to => invitation.recipient_email, :subject  =>  'Приглашение на закрытое тестирование' )    
    invitation.update_attribute(:sent_at, Time.now)
  end
  def hello(user)
  	@from = 'runisov@gmail.com' 
  	@subject = 'HELLO'
  	@to = user.mail
  	@body = 'HELLO!'
  	mail(:from => 'runisov@gmail.com', :to => 'foonduck@list.ru')
  end
end
