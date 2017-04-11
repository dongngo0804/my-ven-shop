class CheckOutMailer < ApplicationMailer
  default from: 'from@example.com'

  def check_out(current_user, current_order)
    @user = current_user
    @order = current_order
    mail(to: @user.email, subject: 'Check out information')
  end
end
