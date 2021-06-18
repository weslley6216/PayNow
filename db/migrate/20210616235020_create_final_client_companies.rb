class CreateFinalClientCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :final_client_companies do |t|
      t.belongs_to :company, null: false, foreign_key: true
      t.belongs_to :final_client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
