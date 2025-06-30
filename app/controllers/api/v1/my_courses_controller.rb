module Api
  module V1
    class MyCoursesController < Api::ApiController

      def index
        enrollments = current_user.enrollments.active.includes(course: { sections: { lessons: :topics } })

        render json: EnrollmentSerializer.new(enrollments, include: ['course', 'course.sections', 'course.sections.lessons', 'course.sections.lessons.topics']).serializable_hash
      end

      def show
        course = Course.find(params[:id])
        unless current_user.courses.include?(course)
          return render json: { error: "Not enrolled in this course." }, status: :forbidden
        end

        render json: CourseSerializer.new(course, include: [:sections, :sections_lessons]).serializable_hash
      end
    end
  end
end
