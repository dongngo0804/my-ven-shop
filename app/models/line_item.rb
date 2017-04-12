class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart

  def total_price
    product.price.to_f * quantity.to_f
  end
end
