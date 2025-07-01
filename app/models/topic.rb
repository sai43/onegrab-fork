class Topic < ApplicationRecord
  belongs_to :lesson
  
  validates :title, presence: true
  validates :content, presence: true
  validates :video_url, format: URI::regexp(%w[http https]), allow_blank: true
  validates :position, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :slug, presence: true, uniqueness: true
  
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :topic_progresses, dependent: :destroy
  accepts_nested_attributes_for :topics, allow_destroy: true
end
