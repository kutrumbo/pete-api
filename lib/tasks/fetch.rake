namespace :fetch do
  desc "Fetch new activities from Strava API"
  task activities: :environment do
    User.all.each do |user|
      StravaService.fetch_activities!(user)
    end
  end

end
