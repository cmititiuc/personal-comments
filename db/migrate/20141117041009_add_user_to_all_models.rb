class AddUserToAllModels < ActiveRecord::Migration
  def change
    add_column :events, :user_id, :integer
    add_column :meals, :user_id, :integer
    add_column :scheduled_events, :user_id, :integer
    add_column :schedules, :user_id, :integer

    add_index "events", ["user_id"], name: "index_events_on_user_id"
    add_index "meals", ["user_id"], name: "index_meals_on_user_id"
    add_index "scheduled_events", ["user_id"], name: "index_scheduled_events_on_user_id"
    add_index "schedules", ["user_id"], name: "index_schedules_on_user_id"
  end
end
