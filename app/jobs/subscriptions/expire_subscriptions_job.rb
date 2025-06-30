class Subscriptions::ExpireSubscriptionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    expired_subscriptions = Subscription.where(status: [:active, :pending]).where("ends_at <= ?", Time.current)

    expired_subscriptions.find_each do |subscription|
      subscription.auto_expire!
      Rails.logger.info "✅ Subscription ##{subscription.id} auto-expired"
    end
  end
end
