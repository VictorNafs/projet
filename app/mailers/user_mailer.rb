class UserMailer < ApplicationMailer
  default from: 'cmoikvolelorange@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = 'https://leasing-vehicule-487e54fd46f7.herokuapp.com/login' # replace with your login url
    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end

  def checkout_email(order)
    @order = order
    mail(to: @order.email, subject: 'Confirmation de votre achat')
  end

  def contact_email(email, message, name)
    @name = name
    @email = email
    @message = message

    mail(to: 'cmoikvolelorange@gmail.com', subject: 'Nouveau message de contact')
  end

end
