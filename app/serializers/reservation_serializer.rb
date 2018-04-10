class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :time, :guest_count, :guest, :created_at, :updated_at
  has_one :table

  def guest
    {
      id: object.guest.id.to_s,
      name: object.guest.name,
      email: object.guest.email
    }
  end
end
