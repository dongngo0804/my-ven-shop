class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    if @line_item.save
      flash[:notice] = 'Product successful added to cart'
      redirect_to :back
    else
      flash[:danger] = 'There was some errors'
      redirect_back(fallback_location: root_url)
    end
  end

  def show
    @line_items = @cart.line_items
  end

  def destroy
    LineItem.find(params[:id]).destroy
    flash[:success] = 'Deleted'
    redirect_to :back
  end
end
