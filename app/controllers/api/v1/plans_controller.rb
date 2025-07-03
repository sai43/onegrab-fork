module Api
  module V1
    class PlansController < Api::ApiController
      skip_before_action :authenticate_user!

      def index
        plans = Rails.cache.fetch("active_plans", expires_in: 24.hours.to_i) do
          Plan.active.to_a
        end
        render json: plans, each_serializer: PlanSerializer
      end
    end
  end
end
