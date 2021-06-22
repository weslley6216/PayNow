class Admin::ChargesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_status_options, only: %i[show update]

  def index
    @company = Company.find_by!(token: params[:company_token])
    @charges = Charge.all
  end

  def show
    @company = Company.find_by!(token: params[:company_token])
    @charge = Charge.find(params[:id])
  end
  
  def update
    @company = Company.find_by!(token: params[:company_token])
    @charge = Charge.find(params[:id])
    @charge.update(charge_params)
    redirect_to admin_company_charge_path(@company.token, @charge), notice: 'Cobrança atualizada com sucesso'
  end

  private

  def set_status_options
    @status_options = Charge.statuses.keys.map { |status| [Charge.human_enum_name(:status, status), status] }
  end

  def charge_params
    params.require(:charge).permit(:status)
  end
end
