class UserMailer < ApplicationMailer
  default from: 'notifications@rottenmangoes.com'

  def deletion(user)
    @user = user
    #here i define the variables i want available in the view that becomes the email
    mail(to: @user.email, subject: 'Account Deletion Notification')
  end

end
