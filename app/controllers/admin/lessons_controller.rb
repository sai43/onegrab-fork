module Admin
  class LessonsController < BaseController
    before_action :set_lesson, only: %i[show edit update destroy]
    before_action :set_section

    def new
      @lesson = @section.lessons.new
    end

    def create
      @lesson = @section.lessons.new(lesson_params)
      if @lesson.save
        redirect_to admin_course_path(@section.course), notice: "Lesson created."
      else
        render :new
      end
    end

    def edit; end
    def show; end

    def update
      if @lesson.update(lesson_params)
        redirect_to admin_course_path(@section.course), notice: "Lesson updated."
      else
        render :edit
      end
    end

    def destroy
      @lesson.destroy
      redirect_to admin_course_path(@section.course), notice: "Lesson deleted."
    end

    private

    def set_section
      @section = @lesson.section
    end

    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:title, :content, :position, :duration, :published)
    end
  end
end
