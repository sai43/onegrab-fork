class LessonSerializer
  include JSONAPI::Serializer
  
  attributes :id, :title, :duration, :position, :content

  belongs_to :section, serializer: SectionSerializer
  has_many :topics, serializer: TopicSerializer

  attribute :progress do |object, params|
    enrollment = Enrollment.find_by(user_id: params[:user]&.id, course_id: object.section.course.id)
    if enrollment.nil?
      0
    else
      progresses = params[:progress_map][enrollment.id] || []
      topic_ids = object.topics.pluck(:id)
      completed_count = progresses.count { |p| topic_ids.include?(p.topic_id) }

      total_topics = topic_ids.size
      if total_topics.zero?
        0
      else
        ((completed_count.to_f / total_topics) * 100).round
      end
    end
  end
end
