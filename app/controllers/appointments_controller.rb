class AppointmentsController < ApplicationController
  def create
    appointment = Appointment.new(
      user: current_user,
      doctor: Doctor.find(params[:doctor_id]),
    )

    date, hour = params[:slot].split(' ')
    day, month, year = date.split('/')

    appointment.appointment_start = Time.new(year, month, day, hour)
    appointment.appointment_end = Time.new(year, month, day, hour.to_i + 1)

    if appointment.save
      redirect_to dashboard_path
    else
      #
    end
  end

  def dashboard
    now = Time.now
    this_hour = Time.new(now.year, now.month, now.day, now.hour)

    @appointment = current_user.current_appointment
    @past_appointments = current_user.appointments.where('appointment_start < ?', this_hour)
    @future_appointments = current_user.appointments.where('appointment_start > ?', this_hour)
    @reviews = current_user.reviews unless current_user.doctor?
  end
end
