class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :check_availability_of_product, only: :create

  def new
  end

  def create
    @line_item = @cart.add_product(@product, @quantity)
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

  private

    def check_availability_of_product 
      @product = Product.find(params[:line_item][:product_id])
      @quantity = params[:line_item][:quantity].gsub(/\D/, '').to_i
      unless @product.stock >= @quantity
        flash[:danger] = "Please order only what is available"
        redirect_to :back
      end
    end

end
