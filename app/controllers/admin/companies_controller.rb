class Admin::CompaniesController < ApplicationController
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

  private

  def company_params
    params.require(:company).permit(:corporate_name, :cnpj, :billing_address, :billing_email, :token)
  end
end