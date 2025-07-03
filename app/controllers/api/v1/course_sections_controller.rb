module Api
  module V1
    class CourseSectionsController < Api::ApiController

      def show
        section = Section.includes(lessons: :topics).find(params[:id])
        course = section.course

        enrollment = current_user.enrollments.find_by(course_id: course.id)
        unless enrollment
          render json: { error: "You are not enrolled in this course" }, status: :forbidden
          return
        end

        cache_key = CacheKey.key(resource: "sections", id: params[:id])

        section_json = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
          Rails.logger.info("⛳ Fetching and caching section data for key: #{cache_key}")
          SectionSerializer.new(section, include: [:'lessons.topics']).serializable_hash
        end

        render json: section_json
      end
    end
  end
end
