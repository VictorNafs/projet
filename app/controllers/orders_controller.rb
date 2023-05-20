# frozen_string_literal: true

class OrdersController < StoreController
  helper 'spree/products', 'orders'

  respond_to :html

  before_action :store_guest_token

  def show
    @order = Spree::Order.find_by!(number: params[:id])
    authorize! :show, @order, cookies.signed[:guest_token]
  end

  def populate
    product_ids = params[:product_ids]
    success = true
    last_product = nil
  
    product_ids.each do |product_id|
      product = Spree::Product.find(product_id)
      last_product = product
      variant = product.master
      date = params[:selected_date].to_date
      time_slot = params[:time_slot]
  
      stock_movement = Spree::StockMovement.where(stock_item_id: variant.stock_items.first.id, date: date).first
  
      # Ajouter le produit au panier avec le numéro du produit, la date et le créneau horaire
      line_item = current_order.contents.add(variant, 1)
    
      # Mettre à jour la date et le créneau horaire de l'article de commande (line_item)
      if line_item.update(date: date, time_slot: time_slot)
        # Marquer le stock_movement comme réservé
        # stock_movement.update(reserved: true)
      else
        success = false
      end
    end
  
    if success
      flash[:success] = I18n.t(:successfully_added_to_your_cart)
      redirect_to main_app.product_path(last_product)
    else
      flash[:error] = I18n.t(:not_all_items_added_to_cart)
      redirect_to main_app.product_path(last_product)
    end
  end
 
  
  
  
  

  
  private

  def store_guest_token
    cookies.permanent.signed[:guest_token] = params[:token] if params[:token]
  end

  def order_params
    {
      user_id: spree_current_user&.id,
      store_id: current_store.id,
      currency: current_currency,
      guest_token: cookies.signed[:guest_token]
    }
  end

  def current_currency
    "USD" # Remplacez par la devise souhaitée
  end
end
