module Admin
  class CoursesController < ApplicationController
    before_action :authenticate_admin!

    def index
      @courses = Course.order(created_at: :desc)
    end

    def show
      @course = Course.find(params[:id])
    end

    def new
      @course = Course.new
      @course.sections.build.lessons.build.topics.build
    end

    def create
      @course = Course.new(course_params)
      if @course.save
        redirect_to admin_course_path(@course), notice: "Course created successfully."
      else
        render :new
      end
    end

    def edit
      @course = Course.find(params[:id])
    end

    def update
      @course = Course.find(params[:id])
      if @course.update(course_params)
        redirect_to admin_course_path(@course), notice: "Course updated successfully."
      else
        render :edit
      end
    end

    def destroy
      @course = Course.find(params[:id])
      @course.destroy
      redirect_to admin_courses_path, notice: "Course deleted."
    end

    private

    def course_params
      params.require(:course).permit(
        :title, :description, :short_description, :price,
        :published, :slug, :thumbnail_url,
        sections_attributes: [
          :id, :title, :description, :_destroy,
          lessons_attributes: [
            :id, :title, :content, :duration, :_destroy,
            topics_attributes: [
              :id, :title, :slug, :content, :notes, :video_url, :position, :_destroy
            ]
          ]
        ]
      )
    end
  end
end
