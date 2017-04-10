json.extract! schedule, :id, :mondayStart, :mondayEnd, :tuesdayStart, :tuesdayEnd, :wednesdayStart, :wednesdayEnd, :thursdayStart, :thursdayEnd, :fridayStart, :fridayEnd, :created_at, :updated_at
json.url schedule_url(schedule, format: :json)
