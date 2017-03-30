module CurrentCart
  private

  def set_cart
    @cart = Cart.find(cookies.permanent[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    cookies.permanent[:cart_id] = @cart.id
  end
end
