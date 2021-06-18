class FinalClientCompany < ApplicationRecord
  belongs_to :company
  belongs_to :final_client

  validates :final_client_id, uniqueness: { scope: :company_id }
  validates :final_client, uniqueness: true
end
