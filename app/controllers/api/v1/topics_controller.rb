module Api
  module V1
    class TopicsController < Api::ApiController
      before_action :set_topic

      def update
        progress = current_user.topic_progresses.find_or_initialize_by(topic: @topic)
        progress.completed = params[:completed]
        if progress.save
          render json: { message: "Progress updated." }, status: :ok
        else
          render json: { error: progress.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def mark_complete
        lesson = @topic.lesson
        section = lesson.section
        course = section.course
        enrollment = Enrollment.find_by!(user_id: current_user.id, course_id: course.id)

        progress = TopicProgress.find_or_initialize_by(
          enrollment: enrollment,
          lesson: lesson,
          topic: @topic
        )

        progress.completed = params[:completed]
        progress.completed_at = params[:completed] ? Time.current : nil
        progress.started_at ||= Time.current
        progress.save!

        render json: { success: true, completed: progress.completed }
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, error: "Topic or enrollment not found" }, status: :not_found
      end

      private

      def set_topic
        @topic = Topic.find(params[:id])
      end
    end
  end
end
