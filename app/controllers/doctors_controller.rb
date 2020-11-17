class DoctorsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @doctors = []

    Doctor.all.each do |doctor|
      @doctors << {
        doctor: doctor,
        specializations: JSON.parse(doctor.specializations),
        rating: average_rating(doctor.reviews)
      }
    end
  end

  def show
    @doctor = Doctor.find(params[:id])
    @reviews = @doctor.reviews
    @articles = @doctor.articles
    @specializations = JSON.parse(@doctor.specializations)
    @rating = average_rating(@reviews)
  end

  private

  def average_rating(reviews)
    rating = 0.0
    reviews.each { |review| rating += review.rating }
    reviews.empty? ? 0 : (rating / reviews.size).round(1)
  end
end
