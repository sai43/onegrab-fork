class SectionSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description, :duration, :position

  has_many :lessons, serializer: LessonSerializer
end
