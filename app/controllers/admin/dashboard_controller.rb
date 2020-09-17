class Admin::DashboardController < ApplicationController
  def show
    @products_count = Product.count
    @categories_count = Category.count('id', :distinct => true)
  end

  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['HTTP_USERNAME'] && password == ENV['HTTP_PASSWORD']
    end
  end

end



