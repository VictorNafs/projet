module Spree
  module OrderContentsExtension
    def self.prepended(base)
      base.prepend(InstanceMethods)
    end

    module InstanceMethods
      def add(variant, quantity = 1, product_number = nil, options = {})
        line_item = order.find_line_item_by_variant(variant, options)
      
        if line_item.nil?
          line_item = order.line_items.new(quantity: quantity,
                                           variant: variant,
                                           options: options)
        else
          line_item.quantity += quantity.to_i
        end

        line_item.product_number = product_number
        line_item.date = options[:date] if options.key?(:date)
        line_item.time_slot = options[:time_slot] if options.key?(:time_slot)
        line_item.target_shipment = options[:shipment] if options.key?(:shipment)
      
        line_item_changed = line_item.changed?
        line_item.save!
        after_add_or_remove(line_item, options) if line_item_changed
      
        line_item
      end

      def add_to_line_item(variant, quantity, options = {})
        line_item = add(variant, quantity, options)
        line_item.save!
        line_item
      end

      def after_add_or_remove(line_item, options)
        # Mettre à jour la date et l'heure de l'achat du produit
        line_item.variant.product.update(purchase_date: options[:date], purchase_time_slot: options[:time_slot])
      end
    end
  end
end

Rails.application.config.to_prepare do
  Spree::OrderContents.prepend Spree::OrderContentsExtension
end
