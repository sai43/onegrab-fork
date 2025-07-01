module Admin
  class SectionsController < BaseController
    before_action :set_section, only: %i[show edit update destroy]
    before_action :set_course

    def new
      @section = @course.sections.new
    end

    def create
      @section = @course.sections.new(section_params)
      if @section.save
        redirect_to admin_course_path(@course), notice: "Section created."
      else
        render :new
      end
    end

    def edit; end

    def show;end

    def update
      if @section.update(section_params)
        redirect_to admin_course_path(@course), notice: "Section updated."
      else
        render :edit
      end
    end

    def destroy
      @section.destroy
      redirect_to admin_course_path(@course), notice: "Section deleted."
    end

    private

    def set_course
      @course = @section.course
    end

    def set_section
      @section = Section.find(params[:id])
    end

    def section_params
      params.require(:section).permit(:title, :description, :position, :duration, :published)
    end
  end
end
