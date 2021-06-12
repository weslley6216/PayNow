class User::CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      current_user.company_id = @company
      @company.users << current_user
      redirect_to [:user, @company], notice: 'Empresa Cadastrada com Sucesso'
    else
      render :new
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  private

  def company_params
    params.require(:company).permit(:corporate_name, :cnpj, :billing_address, :billing_email)
  end

end