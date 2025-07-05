# frozen_string_literal: true

class TopicSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :video_url, :position, :slug

  attribute :content do |topic|    
    ReverseMarkdown.convert(topic.content.body&.to_html)
  end

  attribute :notes do |topic|
    topic.notes.present? ? ReverseMarkdown.convert(topic.notes.body.to_html) : nil
  end

  belongs_to :lesson, serializer: LessonSerializer
end
