class RemoveAthleteIdIndexFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, name: "index_users_on_athlete_id"
  end
end
