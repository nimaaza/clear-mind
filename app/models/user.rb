class User < ApplicationRecord
  validates :email, presence: true

  has_many :appointments
  has_many :reviews
  has_one :doctor
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def appointments
    doctor? ? doctor.appointments : super
  end

  def current_appointment
    # now = Time.now
    # start = Time.new(now.year, now.month, now.day, now.hour, 0, 0)
    # next_hour = Time.new(now.year, now.month, now.day, now.hour + 1, 0, 0)
    # appointments.find_by('appointment_start = ? and appointment_end = ?', start, next_hour)

    Appointment.first
  end

  def doctor?
    doctor.present?
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
