class CourseSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description, :short_description, :price, :level, :duration_minutes, :thumbnail_url

  belongs_to :category, serializer: CategorySerializer
  belongs_to :author, serializer: UserSerializer
  has_many :sections, serializer: SectionSerializer
end
