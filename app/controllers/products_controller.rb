class ProductsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: :show
  before_action :logged_in?, only: :new

  def index
    @recommended_products = Product.order('sales').limit(8)
    @newest_products = Product.order('created_at').limit(10)
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
    @line_item = LineItem.new
  end

  def new
    @product = current_user.products.build

  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:info] = 'Product Saved!'
      redirect_to root_url
    else
      render 'new'
   end
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :original_image_url, :category_id, :stock)
  end
end
