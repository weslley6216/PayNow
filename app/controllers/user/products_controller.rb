class User::ProductsController < ApplicationController
  before_action :set_company

  def index
    @products = @company.products
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.company = current_user.company
    if @product.save
      redirect_to [:user, @company, @product]
    else
      render :new
    end
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :bank_slip_discount, :credit_card_discount, :pix_discount)
  end
end