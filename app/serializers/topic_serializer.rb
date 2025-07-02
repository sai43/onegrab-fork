# frozen_string_literal: true

class TopicSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :video_url, :position, :slug

  attribute :content do |topic|
    body = topic.content.to_plain_text

    if body.present?
      if body.strip.start_with?('<')
        # Convert HTML to Markdown
        ReverseMarkdown.convert(body)
      else
        body # Already Markdown
      end
    end
  end

  attribute :notes do |topic|
    body = topic.notes.to_plain_text

    if body.present?
      if body.strip.start_with?('<')
        ReverseMarkdown.convert(body)
      else
        body
      end
    end
  end

  belongs_to :lesson, serializer: LessonSerializer
end
