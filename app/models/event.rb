class Event < ActiveRecord::Base
  acts_as_commentable
  has_many :scheduled_events
  has_many :schedules, through: :scheduled_events
end
