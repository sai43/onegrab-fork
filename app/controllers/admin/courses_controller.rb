module Admin
  class CoursesController < BaseController
    before_action :set_course, only: %i[show edit update destroy]

    def index
      @courses = Course.recent.published
    end

    def show; end

    def new
      @course = Course.new
    end

    def create
      @course = Course.new(course_params)
      @course.author = current_member

      if @course.save
        redirect_to admin_course_path(@course), notice: "Course created successfully."
      else
        render :new
      end
    end

    def edit; end

    def update
      if @course.update(course_params)
        redirect_to admin_course_path(@course), notice: "Course updated successfully."
      else
        render :edit
      end
    end

    def destroy
      @course.destroy
      redirect_to admin_courses_path, notice: "Course deleted."
    end

    private

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:title, :description, :short_description, :price, :published, :thumbnail_url, :duration_minutes, :slug, :level)
    end
  end
end
