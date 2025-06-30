class User < ApplicationRecord
  GENDERS = %w[male female other].freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :confirmable, :trackable

  validates :first_name, :last_name, :email, :username,  presence: true
  validates :password, presence: true, on: :create
  validates :phone, presence: true, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }

  enum :role, {  member: 0, student: 1, author: 2, teacher: 3, admin: 4 }
  enum :status, { active: 0, inactive: 1, suspended: 2 }, default: :inactive

  has_many :authored_courses, class_name: 'Course', foreign_key: 'author_id'
  has_many :posts, foreign_key: :author_id
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_one :subscription, dependent: :destroy

  after_create :send_confirmation_email

  # Override Devise method to allow login via username or email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)&.downcase

    if login.present?
      where(conditions).where("lower(username) = :value OR lower(email) = :value", { value: login }).first
    else
      email = conditions[:email]&.downcase
      where(conditions).where("lower(email) = ?", email).first
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
  alias_method :name, :full_name

  def subscribed?
    subscription&.status == "active" && subscription.ends_at&.future?
  end

  def current_plan
    subscription&.plan
  end

  def image_url
    return self[:image_url] if self[:image_url].present?

    case gender&.downcase
    when 'male'
      ActionController::Base.helpers.asset_path('boy.png')
    when 'female'
      ActionController::Base.helpers.asset_path('girl.png')
    else
      ActionController::Base.helpers.asset_path('da_male.png')
    end
  end

  private

  def send_confirmation_email
    ConfirmationJob.perform_later(id)
  end
end
