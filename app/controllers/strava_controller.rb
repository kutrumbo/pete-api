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
    json = JSON.parse(response.body)
    if response.success?
      athlete_id = json['athlete']['id']
      user = User.find_or_initialize_by(athlete_id: athlete_id)
      user.update!(
        scope: json['token_type'], # TODO: need to get scope from original auth request
        access_token: json['access_token'],
        refresh_token: json['refresh_token'],
        expires_at: json['expires_at'],
      )
      render json: { athlete_id: athlete_id }, status: :ok
    else
      render json: json, status: response.status
    end
  end
end
