class CreateCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :charges do |t|
      t.decimal :original_value
      t.decimal :discounted_amount
      t.string :token
      t.integer :status, default: 1
      t.string :card_number, null: true
      t.string :card_holder_name, null: true
      t.string :cvv, null: true
      t.string :address, null: true
      t.string :district, null: true
      t.string :zip_code, null: true
      t.string :city, null: true
      t.belongs_to :payment_method, null: false, foreign_key: true
      t.belongs_to :bank_slip, null: true, foreign_key: true
      t.belongs_to :credit_card, null: true, foreign_key: true
      t.belongs_to :pix, null: true, foreign_key: true
      t.belongs_to :company, null: false, foreign_key: true
      t.belongs_to :final_client, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
