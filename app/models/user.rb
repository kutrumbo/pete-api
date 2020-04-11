class User < ApplicationRecord

  def refresh_token!
    response = StravaService.refresh_token!(self.refresh_token)

    self.update!(
      
    )
  end

end
