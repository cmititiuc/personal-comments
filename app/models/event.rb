class Event < ActiveRecord::Base
  has_many :scheduled_events
  has_many :schedules, through: :scheduled_events
end
