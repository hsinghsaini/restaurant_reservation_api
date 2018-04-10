class Shift
  include Mongoid::Document
  field :name, type: String
  field :start, type: String
  field :end, type: String

  include ActiveModel::Validations
  embedded_in :restaurant
  has_many :reservations

  validates_presence_of :name, :start, :end
  validates :start_before_type_cast, time: true
  validates :end_before_type_cast, time: {minimum: :start}
end
