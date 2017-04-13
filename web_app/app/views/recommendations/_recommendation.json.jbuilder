json.extract! recommendation, :id, :professor, :pemail, :student, :semail, :course, :notes, :created_at, :updated_at
json.url recommendation_url(recommendation, format: :json)
