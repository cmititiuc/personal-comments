class RemoveAllButUsersAndComments < ActiveRecord::Migration
  def up
    drop_table :events
    drop_table :meals
    drop_table :schedules
    drop_table :scheduled_events
  end
  
  def down
    create_table :schedules do |t|
      t.string :name
      t.timestamps
    end
    create_table :events do |t|
      t.string :name
      t.timestamps
    end    
    create_table :scheduled_events do |t|
      t.string :day
      t.timestamps
    end
            create_table :meals do |t|
      t.string :period
      t.text :description
      t.timestamps
    end
  end
end
