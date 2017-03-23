class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def categories
  	@categories = Category.all
  end
end
