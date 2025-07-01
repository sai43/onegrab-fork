class Lesson < ApplicationRecord
  belongs_to :section
  has_many :topics, dependent: :destroy
  accepts_nested_attributes_for :topics, allow_destroy: true

  has_many :lesson_progresses, dependent: :destroy
  has_many :users, through: :lesson_progresses
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :position, numericality: { only_integer: true, greater_than: 0 }
  # validates :video_url, format: URI::regexp(%w[http https]), allow_blank: true
  # validates :slug, presence: true, uniqueness: true

  def progress_for_enrollment(enrollment)
    total_topics = topics.count
    return 0 if total_topics.zero?

    completed_topics = TopicProgress.where(enrollment_id: enrollment.id, topic_id: topics.pluck(:id), completed: true).count
    ((completed_topics.to_f / total_topics) * 100).round
  end 
end
