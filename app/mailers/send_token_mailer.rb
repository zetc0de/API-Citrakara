class SendTokenMailer < ApplicationMailer
      
  def forgot_password(user)
    @user = user
    mail(to: @user.email, subject: 'Forgot Password')
  end

end
