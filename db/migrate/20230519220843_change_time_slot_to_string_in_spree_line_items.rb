class ChangeTimeSlotToStringInSpreeLineItems < ActiveRecord::Migration[7.0]
  def change
    change_column :spree_line_items, :time_slot, :string
  end
end
