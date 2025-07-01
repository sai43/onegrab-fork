module Admin
  class DashboardController < BaseController
    def index
      @total_users        = User.count
      @active_enrollments = Enrollment.where(status: :active).count
      @published_courses  = Course.where(published: true).count
      @total_earnings     = Subscription.active.sum(:amount)

      @recent_comments    = Comment.order(created_at: :desc).limit(5)

      @earnings_chart_data = Subscription
        .active
        .group_by_month(:started_at, last: 6)
        .sum(:amount)

      @enrollment_growth_data = Enrollment
        .group_by_month(:created_at, last: 6)
        .count
    end
  end
end
