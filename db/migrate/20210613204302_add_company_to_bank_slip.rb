class AddCompanyToBankSlip < ActiveRecord::Migration[6.1]
  def change
    add_reference :bank_slips, :company, null: false, foreign_key: true
  end
end
