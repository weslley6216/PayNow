class Admin::ChargesController < ApplicationController
  def index
    @company = Company.find_by!(params[:company_id])
    @charges = Charge.all
  end

  def show
    @charge = Charge.find(params[:id])
  end
end
