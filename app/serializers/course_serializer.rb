class CourseSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description, :short_description, :level, :duration_minutes, :thumbnail_url, :slug

  attribute :price do |object|
    price_value = object.price.to_f
    formatted_price = price_value % 1 == 0 ? price_value.to_i : price_value
    "₹#{formatted_price}"
  end

  belongs_to :category, serializer: CategorySerializer
  belongs_to :author, serializer: UserSerializer
  has_many :sections, serializer: SectionSerializer

  attribute :progress do |object, params|
    enrollment = Enrollment.find_by(user_id: params[:user]&.id, course_id: object.id)
    if enrollment
      object.progress_for_enrollment(enrollment)
    else
      0
    end
  end
end
