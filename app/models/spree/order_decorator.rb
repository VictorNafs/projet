Spree::Order.state_machine.after_transition to: :complete, do: :notify_store_of_new_order

    def notify_store_of_new_order
      # ici, vous pouvez déterminer l'email du magasin en fonction de l'ordre
      # en supposant que vous ayez un attribut `store_email` sur vos produits
      store_email = self.line_items.first.product.store_email
    
      # Ensuite, vous pouvez envoyer un e-mail à ce magasin.
      # Ici, je suppose que vous avez une classe `StoreMailer` avec une méthode `new_order_email`.
      StoreMailer.new_order_email(self, store_email).deliver_now
    end
    