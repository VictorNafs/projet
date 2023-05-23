class ChangeTimeSlotToStringInSpreeStockMovements < ActiveRecord::Migration[7.0]
  def change
    change_column :spree_stock_movements, :time_slot, :string
  end
end
