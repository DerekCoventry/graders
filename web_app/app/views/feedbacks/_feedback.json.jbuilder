json.extract! feedback, :id, :professor, :pemail, :courseNumber, :sectionNumber, :semail, :sname, :rating, :notes, :student_id, :created_at, :updated_at
json.url feedback_url(feedback, format: :json)
