module Api
  module V1
    class MyCoursesController < Api::ApiController

      def index
        enrollments = current_user.enrollments.active.includes(:course)
        render json: EnrollmentSerializer.new(enrollments).serializable_hash
      end

      def show
        course = Course.find_by(slug: params[:id])

        # Check enrollment for current_user
        enrollment = current_user.enrollments.find_by(course_id: course.id)

        unless enrollment
          render json: { error: "You are not enrolled in this course" }, status: :forbidden
          return
        end

        render json: CourseSerializer.new(course, include: [:sections, :'sections.lessons', :'sections.lessons.topics'])
      end
    end
  end
end
