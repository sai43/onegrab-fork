class Section < ApplicationRecord
  belongs_to :course
  has_many :lessons, dependent: :destroy
  # accepts_nested_attributes_for :lessons, allow_destroy: true

  validates :title, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }  
  validates :position, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, length: { maximum: 500 }, allow_blank: true


  def progress_for_enrollment(enrollment)
    lesson_progresses = lessons.map { |lesson| lesson.progress_for_enrollment(enrollment) }
    return 0 if lesson_progresses.empty?

    (lesson_progresses.sum / lesson_progresses.size.to_f).round
  end
end
