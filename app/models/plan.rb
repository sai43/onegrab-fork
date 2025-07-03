class Plan < ApplicationRecord

  attribute :interval, :string, default: "monthly"
  attribute :status, :string, default: "active"

  enum :interval, { monthly: 0, yearly: 1 }, suffix: true
  enum :status, { active: 0, inactive: 1 }, default: :active

  has_many :subscriptions, dependent: :destroy

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9\-]+\z/, message: "can only contain lowercase letters, numbers, and hyphens" }
  validates :slug, uniqueness: { case_sensitive: false }
  validates :interval, presence: true, inclusion: { in: %w[monthly yearly] }
  validates :status, presence: true, inclusion: { in: %w[active inactive] }
  validates :currency, presence: true, inclusion: { in: %w[INR USD EUR GBP] }, length: { is: 3 }
  validates :interval_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :duration_days, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :description, length: { maximum: 500 }, allow_blank: true
  before_create :set_default_interval, if: -> { interval.blank? }


  scope :by_interval, ->(interval) { where(interval: interval) }
  scope :by_status, ->(status) { where(status: status) }
  scope :by_slug, ->(slug) { where(slug: slug) }
  scope :by_name, ->(name) { where("name ILIKE ?", "%#{name}%") }
  scope :by_price_range, ->(min, max) { where(price: min..max) }
  scope :by_duration, ->(days) { where(duration_days: days) }

  # Custom scopes
  scope :monthly, -> { where(interval: :monthly) }
  scope :yearly, -> { where(interval: :yearly) }
  scope :active, -> { where(active: true) }

  after_save :clear_cache
  after_destroy :clear_cache

  def to_s
    name
  end

  private

  def generate_slug
    self.slug = name.parameterize
  end

  def set_default_interval
    self.interval ||= :monthly
  end

  def clear_cache
    Rails.cache.delete('active_plans')
  end 
end
