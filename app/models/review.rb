class Review < ApplicationRecord
  validates :content, :rating, presence: true
  validates :rating, inclusion: { in: (1..5) }

  belongs_to :doctor
  belongs_to :user
end
