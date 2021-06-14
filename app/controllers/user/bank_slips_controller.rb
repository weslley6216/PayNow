class User::BankSlipsController < ApplicationController
  before_action :set_payment_method

  def new
    @bank_slip = BankSlip.new
  end

  def create
    @bank_slip = BankSlip.new(bank_slip_params)
    @bank_slip.company = current_user.company
    @bank_slip.payment_method = @payment_method
    if @bank_slip.save
      redirect_to [:user, @payment_method, @bank_slip], notice: 'Dados Cadastrados com Sucesso'
    else
      render :new
    end
  end

  def show
    @bank_slip = BankSlip.find(params[:id])
  end

  private

  def bank_slip_params
    params.require(:bank_slip).permit(:bank_number, :agency_number, :account_number, :payment_method_id, :company_id)
  end

  def set_payment_method
    @payment_method = PaymentMethod.find(params[:payment_method_id])
  end
end