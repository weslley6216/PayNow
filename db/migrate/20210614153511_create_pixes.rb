class CreatePixes < ActiveRecord::Migration[6.1]
  def change
    create_table :pixes do |t|
      t.string :bank_number
      t.string :pix_key
      t.belongs_to :payment_method, null: false, foreign_key: true
      t.belongs_to :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
