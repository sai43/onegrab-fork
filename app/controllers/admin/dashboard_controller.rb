module Admin
  class DashboardController < BaseController
    def index
      @total_users        = User.count
      @active_enrollments = Enrollment.active.count
      @published_courses  = Course.where(published: true).count
      @total_earnings     = Subscription.active.sum(:amount)

      @recent_comments = Comment.order(created_at: :desc).limit(5)
      @recent_signups  = User.order(created_at: :desc).limit(5)

      @earnings_chart_data = Subscription.active.group_by_month(:started_at, last: 6).sum(:amount)
      @enrollment_growth_data = Enrollment.group_by_month(:created_at, last: 6).count
      @plan_earnings_data = Subscription.active.joins(:plan).group("plans.name").sum(:amount)

      @top_courses = Course.joins(:enrollments).group("courses.id").order("COUNT(enrollments.id) DESC").limit(5).includes(:comments)

      @total_earnings_amount = Subscription.active.sum(:amount)
      @expenses_amount = (@total_earnings_amount * 0.3).round(2)
      @net_profit_amount = @total_earnings_amount - @expenses_amount
      @profit_chart_data = {
        "Earnings" => @total_earnings_amount,
        "Expenses" => @expenses_amount,
        "Net Profit" => @net_profit_amount
      }

      # Author revenue
      author_scope = User.joins(authored_courses: { enrollments: :user }).where.not(role: [:member, :student])
      @auth_revenue_data = author_scope.group("users.first_name", "users.last_name").sum("enrollments.amount_paid")

      # MAU
      @monthly_active_users_data = Enrollment.where.not(last_accessed_at: nil).group_by_month(:last_accessed_at, last: 6).distinct.count(:user_id)

      # Churn & Retention
      @churn_data = Subscription.where(status: :canceled).group_by_month(:canceled_at, last: 6).count
      @retention_data = Subscription.where(status: :active).group_by_month(:started_at, last: 6).count

      # Country
      # @user_country_data = User.group(:country).count.reject { |country, _| country.blank? }

      # Funnel
      @funnel_data = {
        "Enrolled" => Enrollment.count,
        "Started"  => Enrollment.where.not(started_at: nil).count,
        "Completed" => Enrollment.where(status: :completed).count
      }
    end
  end
end
