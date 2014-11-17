class Schedule < ActiveRecord::Base
  has_many :scheduled_events
  has_many :events, through: :scheduled_events
  belongs_to :user
end
