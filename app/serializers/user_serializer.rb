class UserSerializer
  include JSONAPI::Serializer
  #binding.pry
  set_type 'users'
  attributes :email, :api_key
end
