json.extract! course, :id, :sectionNumber, :courseNumber, :mondayStart, :mondayEnd, :tuesdayStart, :tuesdayEnd, :wednesdayStart, :wednesdayEnd, :thursdayStart, :thursdayEnd, :fridayStart, :fridayEnd, :professor, :created_at, :updated_at
json.url course_url(course, format: :json)
