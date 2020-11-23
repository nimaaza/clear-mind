class AppointmentsController < ApplicationController
  def create
    appointment = Appointment.new(
      user: current_user,
      doctor: Doctor.find(params[:doctor_id]),
      status: false,
      meeting_link: 'zoom'
    )

    date, hour = params[:slot].split(' ')
    day, month, year = date.split('/')

    appointment.appointment_start = Time.new(year, month, day, hour)
    appointment.appointment_end = Time.new(year, month, day, hour.to_i + 1)

    if appointment.save
      #
    else
      #
    end
  end

  def dashboard
    now = Time.now
    this_hour = Time.new(now.year, now.month, now.day, now.hour)

    @appointment = User.current_appointment(current_user)

    unless @appointment.nil?
      doctor = @appointment.doctor
      @doctor_full_name = "#{doctor.first_name.capitalize} #{doctor.last_name.capitalize}"
    end

    @past_appointments = current_user.appointments.where('appointment_start < ?', this_hour)
    @reviews = current_user.reviews
  end
end
