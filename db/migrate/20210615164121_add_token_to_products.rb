class AddTokenToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :token, :string
  end
end
