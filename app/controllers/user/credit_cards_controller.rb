class User::CreditCardsController < ApplicationController
  before_action :set_payment_method

  def new
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = CreditCard.new(credit_card_params)
    @credit_card.company = current_user.company
    @credit_card.payment_method = @payment_method
    if @credit_card.save
      redirect_to [:user, @payment_method, @credit_card], notice: 'Dados Cadastrados com Sucesso'
    else
      render :new
    end
  end

  def show
    @credit_card = CreditCard.find(params[:id])
  end

  private

  def set_payment_method
    @payment_method = PaymentMethod.find(params[:payment_method_id])
  end

  def credit_card_params
    params.require(:credit_card).permit(:credit_code)
  end

end