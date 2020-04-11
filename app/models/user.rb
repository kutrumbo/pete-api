class User < ApplicationRecord

  def refresh_token!
    response = StravaService.refresh_token(self.refresh_token)

    if response[:access_token]
      self.update!(
        access_token: response[:access_token],
        refresh_token: response[:refresh_token],
        expires_at: response[:expires_at],
      )
    else
      # TODO: handle error
    end
  end

end
