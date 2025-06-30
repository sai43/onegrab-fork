class LessonProgress < ApplicationRecord
  belongs_to :enrollment
  belongs_to :lesson
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  has_many :ratings, as: :rateable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :resources, as: :resourceable, dependent: :destroy

  enum :status, { incomplete: 0, completed: 1 }
  validates :status, inclusion: { in: statuses.keys }
  validates :progress, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
