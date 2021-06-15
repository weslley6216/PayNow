class User::ProductsController < ApplicationController
  before_action :set_company

  def index
    @products = @company.products
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end
end