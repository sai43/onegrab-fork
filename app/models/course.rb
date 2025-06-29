class Course < ApplicationRecord

  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :short_description, length: { maximum: 500 }, allow_blank: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :level, inclusion: { in: %w[Beginner Intermediate Advanced], message: "%{value} is not a valid level" }, allow_blank: true
  validates :duration_minutes, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :thumbnail_url, format: URI::regexp(%w[http https]), allow_blank: true

  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :course_enrollments
  has_many :students, through: :course_enrollments
end
