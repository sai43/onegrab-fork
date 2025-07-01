class Course < ApplicationRecord
  enum :level, { beginner: "Beginner", intermediate: "Intermediate", advanced: "Advanced" }
  enum :status, { draft: "Draft", published: "Published", archived: "Archived" }, default: :draft

  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :short_description, length: { maximum: 500 }, allow_blank: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :level, inclusion: { in: levels.keys, message: "%{value} is not a valid level" }, allow_blank: true
  validates :duration_minutes, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :thumbnail_url, format: URI::regexp(%w[http https]), allow_blank: true
  validates :slug, uniqueness: true

  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments
  has_many :sections, dependent: :destroy
  accepts_nested_attributes_for :sections, allow_destroy: true
  has_many :comments, as: :commentable, dependent: :destroy

  scope :published, -> { where(published: true) }

  before_create :generate_slug_if_blank

  def self.search(query)
    where("title ILIKE :query OR description ILIKE :query", query: "%#{query}%")
  end

  def self.featured
    where(featured: true)
  end

  def self.recent
    order(created_at: :desc).limit(10)
  end

  def total_duration
    sections.sum(:duration_minutes)
  end

  def progress_for_enrollment(enrollment)
    section_progresses = sections.map { |section| section.progress_for_enrollment(enrollment) }
    return 0 if section_progresses.empty?

    (section_progresses.sum / section_progresses.size.to_f).round
  end
  
  private

  def generate_slug_if_blank
    if self.slug.blank?
      self.slug = title.parameterize
    end
  end
end
