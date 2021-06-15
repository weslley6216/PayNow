class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.decimal :bank_slip_discount
      t.decimal :credit_card_discount
      t.decimal :pix_discount
      t.belongs_to :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
