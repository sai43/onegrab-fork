class PlanSerializer
  include JSONAPI::Serializer
  
  attributes :id, :name, :slug, :description, :price, :currency,
             :interval, :interval_count, :duration_days
end
