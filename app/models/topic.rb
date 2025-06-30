class Topic < ApplicationRecord
  belongs_to :lesson
  
  validates :title, presence: true
  validates :content, presence: true
  validates :video_url, format: URI::regexp(%w[http https]), allow_blank: true
  validates :position, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :slug, presence: true, uniqueness: true
end
