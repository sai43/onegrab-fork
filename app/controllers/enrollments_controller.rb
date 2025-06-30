class EnrollmentsController < ApplicationController

  def index
    if current_member.admin?
      @enrollments = Enrollment.includes(:user, :course).all
    else
      @enrollments = current_member.enrollments.includes(:course)
    end
  end
end
