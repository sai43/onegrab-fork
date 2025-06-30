class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :lesson_progresses, dependent: :destroy

  enum :status, { pending: 0, active: 1, completed: 2, canceled: 3 }, default: :active
  validates :status, inclusion: { in: statuses.keys }
  validates :progress, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  after_create :create_lesson_progresses

  scope :active, -> { where(status: :active) }
  scope :completed, -> { where(status: :completed) }
  scope :canceled, -> { where(status: :canceled) }
  scope :pending, -> { where(status: :pending) }

  def complete!
    update!(status: :completed, completed_at: Time.current)
  end

  def cancel!
    update!(status: :canceled, canceled_at: Time.current)
  end

  def active?
    status == "active"
  end

  def completed?
    status == "completed"
  end

  def canceled?
    status == "canceled"
  end

  private

  def create_lesson_progresses
    lessons = course.sections.includes(:lessons).map(&:lessons).flatten
    lessons.each do |lesson|
      lesson_progresses.create!(lesson: lesson)
    end
  end
end
