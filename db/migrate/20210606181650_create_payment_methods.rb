class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.decimal :tax
      t.decimal :max_tax
      t.boolean :active, default: false, null: false

      t.timestamps
    end
  end
end
