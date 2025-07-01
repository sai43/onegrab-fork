class TopicProgress < ApplicationRecord
  belongs_to :enrollment
  belongs_to :lesson
  belongs_to :topic

  validates :enrollment_id, uniqueness: { scope: :topic_id }
end
