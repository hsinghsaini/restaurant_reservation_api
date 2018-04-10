class TableSerializer < ActiveModel::Serializer
  attributes :id, :name, :minimum_guests, :maximum_guests
end
