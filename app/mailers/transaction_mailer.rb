class TransactionMailer < ApplicationMailer
  def new_transaction_email(user)
    @user = user
    mail(to: @user.email, subject: 'Transaction Notifications')
  end

end
