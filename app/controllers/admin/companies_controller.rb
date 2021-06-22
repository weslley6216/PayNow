class Admin::CompaniesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find_by(token: params[:token])
  end

  def edit
    @company = Company.find_by(token: params[:token])
  end

  def update
    @company = Company.find_by(token: params[:token])
    if @company.update(company_params)
      redirect_to admin_company_path(@company.token), notice: 'Atualizado com sucesso'
    else
      render :edit
    end
  end

  def destroy
    @company = Company.find_by(token: params[:token])
    @company.destroy
    redirect_to admin_companies_path, notice: 'Empresa removida com sucesso'
  end

  def regenerate_token
    @company = Company.find_by(token: params[:token])
    @company.token = SecureRandom.base58(20)
    @company.save
    redirect_to admin_company_path(@company.token), notice: 'Token atualizado com sucesso'
  end

  private

  def company_params
    params.require(:company).permit(:corporate_name, :cnpj, :billing_address, :billing_email, :token)
  end

end
