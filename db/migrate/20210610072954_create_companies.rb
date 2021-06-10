class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :corporate_name
      t.string :cnpj
      t.string :billing_address
      t.string :billing_email
      t.string :token, null: true

      t.timestamps
    end
  end
end
