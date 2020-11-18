class AppointmentsController < ApplicationController
  def create
    appointment = Appointment.new(
      user: current_user,
      doctor: Doctor.find(params[:doctor_id]),
      status: false,
      meeting_link: 'zoom'
    )

    date, hour = params[:slot].split(' ')
    year, month, day = date.split('-')

    appointment.appointment_start = Time.new(year, month, day, hour)
    appointment.appointment_end = Time.new(year, month, day, hour.to_i + 1)

    if appointment.save
      #
    else
      #
    end
  end
end
