class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.integer :athlete_id
      t.string :scope
      t.string :access_token
      t.string :refresh_token
      t.timestamp :expires_at

      t.timestamps
    end
  end
end
