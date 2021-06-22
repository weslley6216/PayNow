class User::CompaniesController < ApplicationController
  before_action :authenticate_user!

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      current_user.company_id = @company.id
      @company.users << current_user
      redirect_to [:user, @company], notice: 'Empresa Cadastrada com Sucesso'
    else
      render :new
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def regenerate_token
    @company = Company.find(params[:id])
    @company.token = SecureRandom.base58(20)
    @company.save
    redirect_to [:user, @company], notice: 'Novo token gerado com sucesso'
  end

  private

  def company_params
    params.require(:company).permit(:corporate_name, :cnpj, :billing_address, :billing_email)
  end

end