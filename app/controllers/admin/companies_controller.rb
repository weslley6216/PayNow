class Admin::CompaniesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      redirect_to [:admin, @company], notice: 'Atualizado com sucesso'
    else
      render :edit
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to admin_companies_path, notice: 'Empresa removida com sucesso'
  end

  def regenerate_token
    @company = Company.find(params[:id])
    @company.token = SecureRandom.base58(20)
    @company.save
    redirect_to [:admin, @company], notice: 'Token atualizado com sucesso'
  end

  private

  def company_params
    params.require(:company).permit(:corporate_name, :cnpj, :billing_address, :billing_email, :token)
  end
end
