class Table
  include Mongoid::Document
  field :name, type: String
  field :minimum_guests, type: Integer
  field :maximum_guests, type: Integer

  embedded_in :restaurant
  has_many :reservations

  validates_presence_of :name, :minimum_guests, :maximum_guests
  validates_uniqueness_of :name, case_sensitive: false
  validates_numericality_of :minimum_guests, greater_than: 0
  validates_numericality_of :maximum_guests, greater_than: :minimum_guests
end
