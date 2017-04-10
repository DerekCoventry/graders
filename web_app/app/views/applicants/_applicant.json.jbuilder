json.extract! applicant, :id, :fname, :lname, :year, :email, :schedule_id, :available, :created_at, :updated_at
json.url applicant_url(applicant, format: :json)
