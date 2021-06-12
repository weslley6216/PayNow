class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company, optional: true

  VALID_EMAIL = /\A[a-z0-9+_.-]+@(?!gmail|yahoo|hotmail|paynow)+\p{L}+\.\p{L}+\.br\z/
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL }
end

