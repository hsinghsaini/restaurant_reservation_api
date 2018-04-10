class Guest
  include Mongoid::Document
  field :name, type: String
  field :email, type: String

  embedded_in :reservation

  validates_presence_of :name, :email
  validates :email, email: true
end
