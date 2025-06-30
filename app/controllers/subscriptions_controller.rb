class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:confirm, :destroy]

  def index
    @subscriptions = Subscription.includes(:user, :plan).order(created_at: :desc)
  end

  def confirm
    if @subscription.update(status: "active")
      redirect_to subscriptions_path, notice: "Subscription confirmed successfully!"
    else
      redirect_to subscriptions_path, alert: "Failed to confirm subscription."
    end
  end

  def destroy
    @subscription.destroy
    redirect_to subscriptions_path, notice: "Subscription deleted successfully!"
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
