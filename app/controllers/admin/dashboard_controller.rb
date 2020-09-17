class Admin::DashboardController < ApplicationController
  def show
    @products_count = Product.count
    @categories_count = Category.count('id', :distinct => true)
    @categories = Category.all
  end
end
