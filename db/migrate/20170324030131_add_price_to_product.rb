class AddPriceToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :sales, :integer
  end
end
