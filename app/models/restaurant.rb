class Restaurant
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :email, type: String
  field :phone, type: Integer

  embeds_many :tables
  embeds_many :shifts
  has_many :reservations
  accepts_nested_attributes_for :shifts, :tables

  validates_presence_of :name, :email, :phone
  validates_uniqueness_of :email, :case_sensitive => false
  validates :email, email: true
  validates :phone, phone: true
end
