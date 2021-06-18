class AddTokenToFinalClient < ActiveRecord::Migration[6.1]
  def change
    add_column :final_clients, :token, :string
  end
end
