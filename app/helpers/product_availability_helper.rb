module ProductAvailabilityHelper
    def available_products(date)
      Product.all.select { |product| product_available?(product, date) }
    end
  
    private
  
    def product_available?(product, date)
      !product.reservations.exists?(start_time: date.beginning_of_day..date.end_of_day)
    end
  end
  