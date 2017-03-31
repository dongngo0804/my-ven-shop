class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i(new create)
  before_action :ensure_cart_isnt_empty, only: :create
  before_action :logged_in?

  def index
    if current_user.admin?
      @orders = Order.all
    else
      @orders = current_user.orders.all
    end
  end

  def create
    @order = Order.new
    @order.add_line_items_from_cart(@cart)
    @order.user_id = current_user.id

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

  def destroy
    @order = Order.find(params[:id])
    @order.user_id = nil
    if @order.destroy!
      flash[:success] = "Deleted!!"
      redirect_to :back
    else
      flash[:danger] = "Oops, something was wrong!"
    end

    authorize! :destroy, @order
  end

  def update
    @order = Order.find(params[:id])
    @order.status = params[:order][:status]
    if @order.save
      flash[:success] = "Updated!"
      redirect_to :back
    else
      flash[:danger] = "Oops, something was wrong!"
    end

    authorize! :update, @order
  end


  private

  def ensure_cart_isnt_empty
    if @cart.line_items.empty?
      flash[:danger] = 'Empty cart!!'
      redirect_to root_path
    end
  end


end
