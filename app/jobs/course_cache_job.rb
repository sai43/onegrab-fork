class CourseCacheJob < ApplicationJob
  queue_as :default

  def perform(course_id)
    course = Course.includes(sections: { lessons: :topics }).find(course_id)

    Rails.cache.write(
      CacheKey.key(resource: "courses", slug: course.slug),
      CourseSerializer.new(course, include: [:sections]).serializable_hash
    )

    course.sections.find_each do |section|
      Rails.cache.write(
        CacheKey.key(resource: "sections", id: section.id),
        SectionSerializer.new(section, include: [:'lessons.topics']).serializable_hash
      )
    end
  end
end
