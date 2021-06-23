class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActionController::ParameterMissing, with: :record_missing

  private

  def not_found
    render json: { errors: 'parãmetros inválidos' }, status: 404
  end

  def record_invalid(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def record_missing
    render json: { errors: 'parâmetros inválidos' }
  end
end
