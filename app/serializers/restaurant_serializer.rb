class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone
  has_many :shifts
  has_many :tables
end
