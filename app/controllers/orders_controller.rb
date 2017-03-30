class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i(new create)
  before_action :ensure_cart_isnt_empty, only: :create
  before_action :logged_in?

  def create
    @order = Order.new
    @order.add_line_items_from_cart(@cart)
    if @order.save
      Cart.destroy(cookies.permanent[:cart_id])
      cookies.permanent[:cart_id] = nil
      flash[:success] = 'Thanks for order'
      CheckOutMailer.delay.check_out(current_user, @order)
      redirect_to root_path
    else
      flash[:danger] = 'There was some errors'
    end
  end

  private

  def ensure_cart_isnt_empty
    if @cart.line_items.empty?
      flash[:danger] = 'Empty cart!!'
      redirect_to root_path
    end
  end

  def logged_in?
    unless current_user
      flash[:notice] = 'Please log in'
      redirect_to new_user_session_path
    end
   end

end
