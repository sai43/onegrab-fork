module Api
  module V1
    class CourseSectionsController < Api::ApiController
      before_action :set_course
      before_action :set_section

      def show
        render json: SectionSerializer.new(@section, include: [:lessons, :'lessons.topics']).serializable_hash
      end

      private

      def set_course
        @course = Course.find(params[:my_course_id])
        unless current_user.courses.include?(@course)
          render json: { error: "Not enrolled in this course." }, status: :forbidden
        end
      end

      def set_section
        @section = @course.sections.find(params[:id])
      end
    end
  end
end
