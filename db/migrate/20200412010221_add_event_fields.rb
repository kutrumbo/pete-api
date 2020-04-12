class AddEventFields < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :time, :timestamp, null: false, default: DateTime.now
    add_column :events, :source, :string, null: false, default: 'client'
    add_column :events, :source_id, :bigint
    add_column :events, :details, :jsonb, null: false, default: {}
  end
end
