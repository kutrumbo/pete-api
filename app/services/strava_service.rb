require 'faraday'

module StravaService
  def self.token_exchange(code)
    token_request_body = {
      code: code,
      client_id: ENV['STRAVA_CLIENT_ID'],
      client_secret: ENV['STRAVA_CLIENT_SECRET'],
      grant_type: 'authorization_code'
    }.to_json

    response = Faraday.post(auth_url, token_request_body, 'Content-Type' => 'application/json')
    json = JSON.parse(response.body)
    HashWithIndifferentAccess.new(
      athlete_id: json.dig('athlete', 'id'),
      token_type: json['token_type'],
      access_token: json['access_token'],
      refresh_token: json['refresh_token'],
      expires_at: json['expires_at'] && Time.at(json['expires_at']),
      errors: json['errors'],
    )
  end

  def self.refresh_token(refresh_token)

  end

  private

  def self.auth_url
    'https://www.strava.com/oauth/token'
  end
end
