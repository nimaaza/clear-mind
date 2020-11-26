require 'opentok'

class MeetingsController < ApplicationController
  def meet
    appointment = current_user.current_appointment
    @doctor = appointment.doctor.full_name
    if appointment.nil?
      #
    else
      load_meeting_variables appointment
    end
  end

  private

  def load_meeting_variables(appointment)
    opentok = OpenTok::OpenTok.new Figaro.env.opentok_api_key, Figaro.env.opentok_api_secret

    if appointment.session_id.present?
      @session_id = appointment.session_id
    else
      @session_id = opentok.create_session.session_id
      appointment.update(session_id: @session_id)
    end

    @api_key = Figaro.env.opentok_api_key
    @token = opentok.generate_token @session_id
  end
end
