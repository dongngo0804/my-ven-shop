class AddCateIdToProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :category_id, :integer
  end
end
