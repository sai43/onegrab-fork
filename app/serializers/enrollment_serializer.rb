class EnrollmentSerializer
  include JSONAPI::Serializer

  attributes :id, :status, :progress, :enrolled_at, :completed_at, :canceled_at

  belongs_to :course, serializer: CourseSerializer
end
