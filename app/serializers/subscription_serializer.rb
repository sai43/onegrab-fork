class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :id, :plan_name, :status, :amount, :currency,
             :started_at, :ends_at, :payment_method

  def plan_name
    object.plan.name
  end
end
