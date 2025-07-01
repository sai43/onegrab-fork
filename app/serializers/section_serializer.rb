class SectionSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description, :duration, :position

  has_many :lessons, serializer: LessonSerializer

  attribute :progress do |object, params|
    enrollment = Enrollment.find_by(user_id: params[:user]&.id, course_id: object.course.id)
    if enrollment
      object.progress_for_enrollment(enrollment)
    else
      0
    end
  end
end
