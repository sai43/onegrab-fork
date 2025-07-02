class EnrollmentSerializer
  include JSONAPI::Serializer

  attributes :id, :status, :progress

  attribute :course_slug do |object|
    object.course.slug
  end

  attribute :course_title do |object|
    object.course.title
  end

  attribute :course_short_description do |object|
    object.course.short_description
  end

  attribute :course_thumbnail_url do |object|
    object.course.thumbnail_url
  end
end
