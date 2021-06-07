class Admin::PaymentMethodsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @payment_methods = PaymentMethod.all
  end

  def show
    @payment_method = PaymentMethod.find(params[:id])
  end

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = PaymentMethod.new(payment_method_params)
    if @payment_method.save
      redirect_to [:admin, @payment_method]
    else
      render :new
    end
  end

  private

  def payment_method_params
    params.require(:payment_method).permit(:name, :tax, :max_tax, :icone)
  end
end