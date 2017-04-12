class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  validate :check_availability_of_product
  after_save :reduce_stock_of_product

  enum status: [:Processing, :Preparing, :Shipping, :Done, :Refund]


  def add_line_items_from_cart(cart)
    cart.line_items.each do |line_item|
      line_item.cart_id = nil
      self.line_items << line_item
      self.total_price += line_item.total_price.to_f
    end
   end

  private

  def reduce_stock_of_product
  	line_items = self.line_items
  	line_items.each do |line|
  		line.product.update_attribute(:stock, line.product.stock - line.quantity)
      line.product.update_attribute(:sales, line.product.sales + line.quantity)
  	end
  end

  def check_availability_of_product
  	line_items = self.line_items
  	line_items.each do |line|
  		unless line.product.stock >= line.quantity
  			self.errors.add(:quantity, "Out of stock")
      end
  	end
  end
end
