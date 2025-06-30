class LessonSerializer
  include JSONAPI::Serializer
  
  attributes :id, :title, :duration, :position

  belongs_to :section, serializer: SectionSerializer
  has_many :topics, serializer: TopicSerializer
end
