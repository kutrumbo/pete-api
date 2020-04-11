class StravaController < ApplicationController
  def token
    response = StravaService.token_exchange(params.require(:code))
    access_token = response[:access_token]

    if access_token
      user = User.find_or_initialize_by(athlete_id: response[:athlete_id])
      user.update!(
        scope: response[:token_type], # TODO: need to get scope from original auth request
        access_token: access_token,
        refresh_token: response[:refresh_token],
        expires_at: response[:expires_at],
      )
      render json: { access_token: access_token }, status: :ok
    else
      render json: response.slice(:errors), status: :bad_request
    end
  end
end
