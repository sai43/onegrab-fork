class StudentsController < ApplicationController
  before_action :set_student, only: [:edit, :update, :destroy, :show]

  def index
    @pagy, @students = pagy(User.where(role: User.roles[:student]).order(created_at: :desc))
  end

  def new 
    @student = User.new
  end

  def create
    @student = User.new(student_params)
    @student.role = User.roles[:student]
    
    if @student.save
      redirect_to students_path, notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to students_path, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end
  def destroy
    if @student.destroy
      redirect_to students_path, notice: 'Student was successfully deleted.'
    else
      redirect_to students_path, alert: 'Failed to delete student.'
    end
  end
  def show
    @enrollments = @student.enrollments.includes(:course).order(created_at: :desc)
  end

  def search
    @pagy, @students = pagy(User.where(role: User.roles[:student]).
                            where("name ILIKE :query OR email ILIKE :query", query: "%#{params[:query]}%").
                            order(created_at: :desc))   

  end

  private

  def set_student
    @student = User.where(id: params[:id], role: User.roles[:student]).first
    unless @student
      redirect_to students_path, alert: 'Student not found.'
    end
  end

  def student_params
    params.require(:user).permit(:name, :email, :phone, :address, :gender, :dob, :enrollment_date, :status, :parent_guardian_name)
  end 

end
