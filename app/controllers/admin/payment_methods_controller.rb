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

  def edit
    @payment_method = PaymentMethod.find(params[:id])
  end

  def update
    @payment_method = PaymentMethod.find(params[:id])
    if @payment_method.update(payment_method_params)
      redirect_to [:admin, @payment_method], notice: 'Meio de Pagamento atualizado com sucesso'
    else
      render :edit
    end
  end

  def destroy
    @payment_method = PaymentMethod.find(params[:id])
    @payment_method.destroy
    redirect_to admin_payment_methods_path, notice: 'Meio de pagamento removido com sucesso '
  end

  private

  def payment_method_params
    params.require(:payment_method).permit(:name, :tax, :max_tax, :icon, :form_of_payment)
  end
end
