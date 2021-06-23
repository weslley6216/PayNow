class Api::V1::ChargesController < Api::V1::ApiController

  def index
    @company = Company.find_by!(token: params[:company_token])
    render json: @company.charges.as_json(except: %i[id
                                                     created_at
                                                     updated_at
                                                     payment_method_id
                                                     bank_slip_id
                                                     credit_card_id
                                                     pix_id
                                                     company_id
                                                     final_client_id
                                                     product_id
                                                    ]), status: 200
  end

  def create
    @company = Company.find_by!(token: params[:charge][:company_token])
    @payment_method = PaymentMethod.find_by(id: params[:charge][:payment_method_id])

    if @payment_method.bank_slip?
      @bank_slip = BankSlip.find_by!(params[:charge][:bank_slip_id])
      @address = params[:charge][:address]
      @district = params[:charge][:district]
      @zip_code = params[:charge][:zip_code]
      @city = params[:charge][:city]
    elsif @payment_method.credit_card?
      @credit_card = CreditCard.find_by!(params[:charge][:credit_card_id])
      @card_number = params[:charge][:card_number]
      @card_holder_name = params[:charge][:card_holder_name]
      @cvv = params[:charge][:cvv]
    else
      @pix = Pix.find_by!(params[:charge][:pix_id])
    end

    @product = Product.find_by!(token: params[:charge][:product_token])
    @final_client = FinalClient.find_by!(token: params[:charge][:final_client_token])
    @charge = Charge.new(charge_params)
    @charge.company = @company
    @charge.final_client = @final_client
    @charge.product = @product
    @charge.original_value = @product.price
    @charge.discounted_amount = apply_discount
    @charge.save!
    render json: @charge.as_json(except: %i[id
                                            created_at
                                            updated_at
                                            payment_method_id
                                            bank_slip_id
                                            credit_card_id
                                            pix_id
                                            company_id
                                            final_client_id
                                            product_id
                                           ]), status: :created

  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Parâmetro inválido' }, status: 422
  rescue ActiveRecord::RecordInvalid
    render json: @charge.errors, status: :unprocessable_entity
  end

  private

  def apply_discount
    if @bank_slip
      @product.price - (@product.price * (@product.bank_slip_discount / 100))
    elsif @credit_card
      @product.price - (@product.price * (@product.credit_card_discount / 100))
    else
      @product.price - (@product.price * (@product.pix_discount / 100))
    end
  end

  def charge_params
    params.require(:charge).permit(:payment_method_id, :bank_slip_id, :credit_card_id, :pix_id,
                                   :address, :district, :zip_code, :city,
                                   :card_number, :card_holder_name, :cvv)
  end
end
