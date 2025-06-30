module Api
  module V1
    class CoursesController < Api::ApiController
      def index
        pagy, courses = pagy(Course.published.includes(:category, :author).order(created_at: :desc), items: 10)

        render json: {
          courses: CourseSerializer.new(courses).serializable_hash,
          pagy: pagy_metadata(pagy)
        }
      end

      def enroll
        unless current_user&.subscribed?
          render json: { error: "You must be subscribed to enroll in courses." }, status: :forbidden and return
        end

        course = Course.find_by(id: params[:id])
        unless course
          render json: { error: "Course not found." }, status: :not_found and return
        end

        if current_user.courses.exists?(course.id)
          render json: { error: "You are already enrolled in this course." }, status: :conflict and return
        end

        enrollment = current_user.enrollments.build(
          course: course,
          enrolled_at: Time.current,
          status: "active",
          **enrollment_params
        )

        if enrollment.save
          render json: { message: "Successfully enrolled in #{course.title}!" }, status: :created
        else
          render json: { error: enrollment.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end

      def unenroll
        course = Course.find_by(id: params[:id])
        unless course
          render json: { error: "Course not found." }, status: :not_found and return
        end

        enrollment = current_user.enrollments.find_by(course: course)
        unless enrollment
          render json: { error: "You are not enrolled in this course." }, status: :not_found and return
        end

        # You can use destroy or soft-cancel
        if enrollment.destroy
          render json: { message: "Successfully unenrolled from #{course.title}." }, status: :ok
        else
          render json: { error: "Failed to unenroll from the course." }, status: :unprocessable_entity
        end
      end

      def show
        course = Course.find_by(id: params[:id])
        unless course
          render json: { error: "Course not found." }, status: :not_found and return
        end

        render json: { course: CourseSerializer.new(course).serializable_hash }, status: :ok
      end

      private

      def enrollment_params
        params.fetch(:enrollment, {}).permit(
          :status, :progress, :enrolled_at, :completed_at, :canceled_at,
          :started_at, :last_accessed_at, :enrollment_type, :payment_status,
          :amount_paid, :currency, :enrollment_source, :enrollment_code,
          :notes, :referral_code, :referral_source, :utm_source, :utm_medium,
          :utm_campaign, :utm_content, :utm_term
        )
      end
    end
  end
end
