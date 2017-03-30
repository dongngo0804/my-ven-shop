class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy

  def add_line_items_from_cart(cart)
    cart.line_items.each do |line_item|
      line_item.cart_id = nil
      self.line_items << line_item
      self.total_price += line_item.total_price
    end
   end
end
