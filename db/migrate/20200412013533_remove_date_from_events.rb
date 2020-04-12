class RemoveDateFromEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :date, :date, null: false
    change_column_default :events, :time, nil
    change_column_default :events, :source, nil
  end
end
