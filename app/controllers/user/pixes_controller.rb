class User::PixesController < ApplicationController
  before_action :set_payment_method

  def new
    @pix = Pix.new
  end

  def create
    @pix = Pix.new(pix_params)
    @pix.company = current_user.company
    @pix.payment_method = @payment_method
    if @pix.save
      redirect_to [:user, @payment_method, @pix], notice: 'Dados Cadastrados com Sucesso'
    else
      render :new
    end
  end

  def show
    @pix = Pix.find(params[:id])
  end

  private

  def set_payment_method
    @payment_method = PaymentMethod.find(params[:payment_method_id])
  end

  def pix_params
    params.require(:pix).permit(:bank_number, :pix_key)
  end
end
