module Api
  module V1
    class PlansController < Api::ApiController
      skip_before_action :authenticate_user!

      def index
        plans = Plan.active
        render json: plans, each_serializer: PlanSerializer
      end
    end
  end
end
