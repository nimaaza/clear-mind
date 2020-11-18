class Doctor < ApplicationRecord
  validates :specializations, :first_name, :last_name,
            :email, :phone_number, :about, presence: true

  has_many :reviews
  has_many :appointments
  has_many :articles

  has_one_attached :avatar

  def free_appointments
    forthcoming_appointments = appointments
                               .where('appointment_start > ?', Time.now)
                               .order(appointment_start: :asc)
    make_white_list(forthcoming_appointments).to_json
  end

  def average_rating
    rating = 0.0
    reviews.each { |review| rating += review.rating }
    reviews.empty? ? 0 : (rating / reviews.size).round(1)
  end

  private

  def make_white_list(appointments)
    white_list = {}

    appointments.each do |appointment|
      start_time = appointment.appointment_start.getlocal
      key = start_time.strftime("%Y-%m-%d")
      start_hour = start_time.hour

      white_list[key] = make_work_hours(appointment) unless white_list.key?(key)
      white_list[key].delete(start_hour)
    end

    white_list
  end

  def make_work_hours(appointment)
    start_time = appointment.appointment_start.getlocal

    if start_time.strftime("%Y-%m-%d") == Time.now.strftime("%Y-%m-%d")
      ((Time.now.hour + 1)..18).to_a
    else
      (9..18).to_a
    end
  end
end
