class TopicSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :content, :video_url, :position, :slug, :notes

  belongs_to :lesson, serializer: LessonSerializer
end
