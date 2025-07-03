module Api
  module V1
    class MyCoursesController < Api::ApiController

      def index
        enrollments = current_user.enrollments.active.includes(:course)
        render json: EnrollmentSerializer.new(enrollments).serializable_hash
      end

      def show
        course = Course.includes(:sections).find_by(slug: params[:id])
        return render json: { error: "Course not found" }, status: :not_found unless course

        enrollment = current_user.enrollments.find_by(course_id: course.id)
        unless enrollment
          render json: { error: "You are not enrolled in this course" }, status: :forbidden
          return
        end

        cache_key = CacheKey.key(resource: "courses", slug: params[:id])

        course_json = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
          Rails.logger.info("⛳ Caching course data for key: #{cache_key}")
          CourseSerializer.new(course, include: [:sections]).serializable_hash
        end

        render json: course_json
      end

      def section_details
        section = Section.includes(lessons: :topics).find(params[:section_id])
        course = section.course

        enrollment = current_user.enrollments.find_by(course_id: course.id)
        unless enrollment
          render json: { error: "You are not enrolled in this course" }, status: :forbidden
          return
        end

        cache_key = CacheKey.key(resource: "sections", id: params[:section_id])

        section_json = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
          SectionSerializer.new(section, include: [:'lessons.topics']).serializable_hash
        end

        render json: section_json
      end

    end
  end
end
