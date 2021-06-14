class CreateBankSlips < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_slips do |t|
      t.string :bank_number
      t.string :agency_number
      t.string :account_number

      t.timestamps
    end
  end
end
