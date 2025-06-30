class CategorySerializer
  include JSONAPI::Serializer

  attributes :id, :name, :description

  attribute :courses_count do |category|
    category.courses.count
  end

  attribute :created_at do |category|
    category.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  attribute :updated_at do |category|
    category.updated_at.strftime("%Y-%m-%d %H:%M:%S")
  end
end
