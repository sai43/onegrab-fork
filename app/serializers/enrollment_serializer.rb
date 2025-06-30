class EnrollmentSerializer
  include JSONAPI::Serializer

  attributes :id, :status, :progress, :enrolled_at, :completed_at, :canceled_at

  attribute :course_title do |object|
    object.course.title
  end

  attribute :course_status do |object|
    object.course.status.titleize rescue nil
  end

  attribute :course_duration do |object|
    object.course.duration_minutes
  end
  
  attribute :course_short_description do |object|
    object.course.short_description rescue nil
  end

  attribute :course_thumbnail_url do |object|
    object.course.thumbnail_url
  end

  attribute :course_slug do |object|
    object.course.slug
  end

  belongs_to :course, serializer: CourseSerializer
end
