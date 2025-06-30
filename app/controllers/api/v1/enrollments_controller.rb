module Api
  module V1
    class EnrollmentsController < Api::ApiController
      def index
        enrollments = current_user.enrollments.active.includes(:course)

        render json: EnrollmentSerializer.new(enrollments, include: [:course]).serializable_hash, status: :ok
      end

      def show
        enrollment = current_user.enrollments.find_by(id: params[:id])
        unless enrollment
          render json: { error: "Enrollment not found." }, status: :not_found and return
        end

        render json: EnrollmentSerializer.new(enrollment, include: [:course]).serializable_hash, status: :ok
      end

      def create
        course = Course.find_by(id: params[:course_id])
        unless course
          render json: { error: "Course not found." }, status: :not_found and return
        end

        if current_user.courses.exists?(course.id)
          render json: { error: "You are already enrolled in this course." }, status: :conflict and return
        end

        enrollment = current_user.enrollments.build(
          course: course,
          enrolled_at: Time.current,
          status: "active"
        )

        if enrollment.save
          render json: EnrollmentSerializer.new(enrollment, include: [:course]).serializable_hash, status: :created
        else
          render json: { error: enrollment.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end

      def bulk_create
        course_ids = params[:course_ids]
        unless course_ids.is_a?(Array) && course_ids.all? { |id| id.is_a?(Integer) }
          render json: { error: "Invalid course IDs." }, status: :unprocessable_entity and return
        end

        enrollments = []
        course_ids.each do |course_id|
          course = Course.find_by(id: course_id)
          next unless course

          unless current_user.courses.exists?(course.id)
            enrollments << current_user.enrollments.build(
              course: course,
              enrolled_at: Time.current,
              status: "active"
            )
          end
        end

        if enrollments.empty?
          render json: { message: "No new enrollments created." }, status: :ok and return
        end

        if Enrollment.import enrollments, on_duplicate_key_ignore: true
          render json: { message: "Successfully enrolled in selected courses." }, status: :created
        else
          render json: { error: "Failed to create enrollments." }, status: :unprocessable_entity
        end
      end

      def progress
        enrollment = current_user.enrollments.find(params[:id])

        total = enrollment.lesson_progresses.count
        completed = enrollment.lesson_progresses.completed.count
        percentage = total.positive? ? ((completed.to_f / total) * 100).round : 0

        lessons = enrollment.lesson_progresses.includes(:lesson).map do |lp|
          {
            id: lp.lesson.id,
            title: lp.lesson.title,
            status: lp.status
          }
        end

        render json: {
          total_lessons: total,
          completed_lessons: completed,
          percentage: percentage,
          lessons: lessons
        }, status: :ok
      end
    end
  end
end
