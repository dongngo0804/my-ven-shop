class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def index
    @line_items = @cart.line_items
  end
end
