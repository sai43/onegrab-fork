module Admin
  class DashboardController < BaseController
    def index
      @total_users        = User.count
      @active_enrollments = Enrollment.active.count
      @published_courses  = Course.where(published: true).count
      @total_earnings     = Subscription.active.sum(:amount)

      @recent_comments = Comment.order(created_at: :desc).limit(5)
      @recent_signups  = User.order(created_at: :desc).limit(5)

      # Earnings data for chart
      @earnings_chart_data = Subscription
        .active
        .group_by_month(:started_at, last: 6)
        .sum(:amount)

      # Enrollment growth data for chart
      @enrollment_growth_data = Enrollment
        .group_by_month(:created_at, last: 6)
        .count

      # Plan-wise earnings breakdown
      @plan_earnings_data = Subscription
        .active
        .joins(:plan)
        .group("plans.name")
        .sum(:amount)

      # Top courses by enrollment count
      @top_courses = Course
        .joins(:enrollments)
        .group("courses.id")
        .order("COUNT(enrollments.id) DESC")
        .limit(5)
    end
  end
end
