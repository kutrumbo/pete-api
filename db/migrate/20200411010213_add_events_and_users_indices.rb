class AddEventsAndUsersIndices < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :athlete_id
    change_column_null :events, :name, false
    change_column_null :events, :date, false
    change_column_null :users, :athlete_id, false
    change_column_null :users, :scope, false
    change_column_null :users, :access_token, false
    change_column_null :users, :refresh_token, false
    change_column_null :users, :expires_at, false
  end
end
