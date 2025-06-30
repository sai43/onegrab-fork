module Api
  module V1
    class LessonProgressesController < Api::ApiController
      before_action :set_enrollment
      before_action :set_lesson_progress

      def update
        @lesson_progress.update!(status: :completed, completed_at: Time.current)
        render json: { message: "Lesson marked as completed!" }, status: :ok
      end

      private

      def set_enrollment
        @enrollment = current_user.enrollments.find(params[:enrollment_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Enrollment not found." }, status: :not_found
      end

      def set_lesson_progress
        @lesson_progress = @enrollment.lesson_progresses.find_by!(lesson_id: params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Lesson progress not found." }, status: :not_found
      end
    end
  end
end
