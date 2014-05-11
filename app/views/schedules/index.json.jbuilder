json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :string
  json.url schedule_url(schedule, format: :json)
end
