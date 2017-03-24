class ProductsController < ApplicationController
  def index
    @recommended_products = Product.order('sales').limit(8)
    @newest_products = Product.order('created_at').limit(10)
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
