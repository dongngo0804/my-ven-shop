class Cart < ApplicationRecord
  # before_action :set_card, only: [:show, :edit, :update, :destroy]

  has_many :line_items, dependent: :destroy

  def add_product(product,quantity)
    current_item = line_items.find_by(product_id: product.id)
    unless current_item
      current_item = line_items.build(product_id: product.id)
    end
      current_item.quantity += quantity

    current_item
  end

end
