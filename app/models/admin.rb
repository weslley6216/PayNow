class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :validatable

  VALID_EMAIL = /\A[a-z0-9+_.-]+@(?=paynow)+\p{L}+\.\p{L}+\.br\z/
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL }
end
