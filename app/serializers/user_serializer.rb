class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :first_name, :last_name, :username, :email, :phone
end
