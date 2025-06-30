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

      private

      def set_topic
        @topic = Topic.find(params[:id])
      end
    end
  end
end
