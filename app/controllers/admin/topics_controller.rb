module Admin
  class TopicsController < BaseController
    before_action :set_topic, only: %i[show edit update destroy]
    before_action :set_lesson

    def new
      @topic = @lesson.topics.new
    end

    def create
      @topic = @lesson.topics.new(topic_params)
      if @topic.save
        redirect_to admin_course_path(@lesson.section.course), notice: "Topic created."
      else
        render :new
      end
    end

    def edit; end

    def show; end

    def update
      if @topic.update(topic_params)
        redirect_to admin_course_path(@lesson.section.course), notice: "Topic updated."
      else
        render :edit
      end
    end

    def destroy
      @topic.destroy
      redirect_to admin_course_path(@lesson.section.course), notice: "Topic deleted."
    end

    private

    def set_lesson
      @lesson = @topic.lesson
    end

    def set_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title, :video_url, :position, :slug, :content, :notes)
    end
  end
end
