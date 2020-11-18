require 'json'

class DoctorsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @doctors = Doctor.all.map do |doctor|
      {
        doctor: doctor,
        specializations: JSON.parse(doctor.specializations),
        rating: doctor.average_rating
      }
    end
  end

  def show
    @doctor = Doctor.find(params[:id])
    @reviews = @doctor.reviews
    @articles = @doctor.articles
    @specializations = JSON.parse(@doctor.specializations)
    @rating = @doctor.average_rating
    @appointment = Appointment.new
    @appointments_white_list = @doctor.free_appointments
  end
end
