class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  enum :status, {
    pending: "pending",
    active: "active",
    canceled: "canceled",
    expired: "expired",
    trialing: "trialing",
    suspended: "suspended"
  }, default: :pending

  validates :status, presence: true
  validates :payment_method, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true

  before_create :set_default_end_date

  scope :active, -> { where(status: statuses[:active]).where("ends_at > ?", Time.current) }
  scope :expired, -> { where(status: statuses[:expired]).or(where("ends_at <= ?", Time.current)) }

  def active_and_valid?
    active? && ends_at.present? && ends_at.future?
  end

  private

  def set_default_end_date
    if ends_at.blank? && started_at.present?
      self.ends_at = started_at + plan.duration_days.days
    end
  end

  def auto_expire
    return unless ends_at.present? && ends_at.past?

    update!(status: :expired)
  end
end
