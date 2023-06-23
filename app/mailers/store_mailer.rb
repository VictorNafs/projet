class StoreMailer < ApplicationMailer
    def new_order_email(order, store_email)
      @order = order
      mail(to: store_email, subject: 'Nouvelle commande reçue')
    end
  end
  