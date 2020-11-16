class Doctor < ApplicationRecord
  validates :specialization, :first_name, :last_name,
            :email, :phone_number, :about, presence: true

  has_many :reviews
  has_many :appointments
  has_many :articles
end
