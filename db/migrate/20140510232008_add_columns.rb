class AddColumns < ActiveRecord::Migration
  def change
    add_column :scheduled_events, :schedule_id, :integer
    add_column :scheduled_events, :event_id, :integer
  end
end
