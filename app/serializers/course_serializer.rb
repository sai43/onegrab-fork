class CourseSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description, :short_description, :level, :duration_minutes, :thumbnail_url

  attribute :price do |object|
    price_value = object.price.to_f
    formatted_price = price_value % 1 == 0 ? price_value.to_i : price_value
    "₹#{formatted_price}"
  end

  belongs_to :category, serializer: CategorySerializer
  belongs_to :author, serializer: UserSerializer
  has_many :sections, serializer: SectionSerializer
end
