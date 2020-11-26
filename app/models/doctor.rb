class Doctor < ApplicationRecord
  validates :specializations, :first_name, :last_name,
            :email, :phone_number, :about, presence: true

  has_many :reviews, dependent: :destroy 
  has_many :appointments, dependent: :destroy 
  has_many :articles, dependent: :destroy 
  belongs_to :user
  has_one_attached :avatar

  def average_rating
    rating = 0.0
    reviews.each { |review| rating += review.rating }
    reviews.empty? ? 0 : (rating / reviews.size).round(1)
  end

  def free_appointments
    forthcoming_appointments = appointments
                               .where('appointment_start > ?', Time.now)
                               .order(appointment_start: :asc)
    make_white_list(forthcoming_appointments).to_json
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  private

  def make_white_list(appointments)
    white_list = {}

    appointments.each do |appointment|
      start_time = appointment.appointment_start.getlocal
      key = start_time.strftime('%d/%m/%Y')
      start_hour = start_time.hour

      white_list[key] = (9..20).to_a unless white_list.key?(key)
      white_list[key].delete(start_hour)
    end

    # today would require some special treatment to
    # remove free slots for which the hour has passed
    # and add free slots for the rest of the day if
    # there have been no appointments
    today = Time.now.getlocal.strftime('%d/%m/%Y')
    this_hour = Time.now.getlocal.hour.to_i

    if white_list[today].present?
      (9..this_hour).each { |hour| white_list[today].delete(hour) }
    else
      white_list[today] = (this_hour..20).to_a
    end

    white_list
  end
end
