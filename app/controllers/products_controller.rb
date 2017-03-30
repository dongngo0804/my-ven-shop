class ProductsController < ApplicationController
  def index
    @recommended_products = Product.order('sales').limit(8)
    @newest_products = Product.order('created_at').limit(10)
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)

    # @product['large_image_url'] = 'large_' + params[:original_image_url]
    if @product.save
      flash[:info] = 'Product Saved!'
      # redirect_to root_url
    else
      render 'new'
   end
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :original_image_url, :category_id)
  end
end
