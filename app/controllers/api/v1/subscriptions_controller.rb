module Api
  module V1
    class SubscriptionsController < Api::ApiController

      def show
        subscription = current_user.subscription

        if subscription.present?
          render json: subscription, serializer: SubscriptionSerializer
        else
          render json: { message: "No subscription found" }, status: :ok
        end
      end

      def create
        if current_sub.present? && current_sub.pending?
          return render json: {
            error: "You already have a pending subscription for '#{current_sub.plan.name}'. Do you want to change it to this new plan?"
          }, status: :unprocessable_entity
        end

        plan = Plan.find_by(id: params[:plan_id])
        return render json: { error: "Plan not found" }, status: :not_found unless plan

        subscription = current_user.build_subscription(
          plan: plan,
          amount: plan.price,
          currency: plan.currency,
          status: "pending",
          started_at: Time.current,
          ends_at: Time.current + plan.duration_days.days,
          payment_method: "cash"
        )

        if subscription.save
          render json: subscription, serializer: SubscriptionSerializer, status: :created
        else
          render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def cancel
        subscription = current_user.subscription
        return render json: { error: "No subscription to cancel" }, status: :not_found unless subscription

        subscription.update!(status: "canceled", canceled_at: Time.current, cancel_reason: params[:reason])
        render json: { message: "Subscription canceled successfully" }
      end

      private

      def current_sub
        current_user.subscription
      end
    end
  end
end
