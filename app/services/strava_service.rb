require 'faraday'

module StravaService

  ACTIVITY_NAME_MAP = {
    'Yoga' => 'yoga',
    'Run' => 'running',
    'Ride' => 'cycling',
  }.freeze

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

  def self.refresh_token(user)
    token_request_body = {
      refresh_token: user.refresh_token,
      client_id: ENV['STRAVA_CLIENT_ID'],
      client_secret: ENV['STRAVA_CLIENT_SECRET'],
      grant_type: 'refresh_token'
    }.to_json

    response = Faraday.post(auth_url, token_request_body, 'Content-Type' => 'application/json')
    json = JSON.parse(response.body)
    HashWithIndifferentAccess.new(
      token_type: json['token_type'],
      access_token: json['access_token'],
      refresh_token: json['refresh_token'],
      expires_at: json['expires_at'] && Time.at(json['expires_at']),
      errors: json['errors'],
    )
  end

  def self.fetch_activities!(user, after=1.week.ago.to_i)
    params = {
      page: 1,
      per_page: 100,
      after: after,
    }
    strava_events = []
    more_events = true

    while more_events
      response = Faraday.get(activities_url, params, 'Authorization' => "Bearer #{user.access_token}")
      if response.success?
        new_events = JSON.parse(response.body)
        strava_events += new_events
        params[:page] += 1
        more_events = new_events.length == params[:per_page]
      elsif response.status == 401
        user.refresh_token!
        fetch_activities!(user, after)
        return
      else
        return
      end
    end

    strava_events.each do |strava_event|
      persist_strava_event(strava_event)
    end
  end

  private

  def self.persist_strava_event(strava_event)
    event = Event.find_or_initialize_by(source: 'strava', source_id: strava_event['id'])
    event.update!(
      name: ACTIVITY_NAME_MAP[strava_event['type']],
      time: DateTime.parse(strava_event['start_date']),
      details: strava_event,
    )
  end

  def self.auth_url
    'https://www.strava.com/oauth/token'
  end

  def self.activities_url
    'https://www.strava.com/api/v3/athlete/activities'
  end
end
