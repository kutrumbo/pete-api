require 'faraday'

class StravaController < ApplicationController
  def token
    url = 'https://www.strava.com/oauth/token'
    token_request_body = {
      code: params.require(:code),
      client_id: ENV['STRAVA_CLIENT_ID'],
      client_secret: ENV['STRAVA_CLIENT_SECRET'],
      grant_type: 'authorization_code'
    }.to_json
    response = Faraday.post(url, token_request_body, 'Content-Type' => 'application/json')
    if response.success?
      render status: :created
    else
      render json: response.body, status: response.status
    end
  end
end
