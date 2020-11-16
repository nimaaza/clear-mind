class User < ApplicationRecord
  validates :email, :phone_number, presence: true

  has_many :appointments
  has_many :reviews

  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
