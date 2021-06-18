class Api::V1::FinalClientsController < Api::V1::ApiController
  def create
    @company = Company.find_by(token: params[:company_token])
    unless @final_client = FinalClient.find_by(cpf: params[:final_client][:cpf])
      @final_client = FinalClient.create!(final_client_params)
    end
    @client_company = @final_client.final_client_companies.create!(company: @company)
    render json: @final_client, status: :created
  rescue ActiveRecord::RecordInvalid
    if @final_client.errors.any?
      render json: @final_client.errors, status: :unprocessable_entity
    else
      render json: @client_company.errors, status: :unprocessable_entity
    end
  end

  private

  def final_client_params
    params.require(:final_client).permit(:name, :cpf)
  end
end