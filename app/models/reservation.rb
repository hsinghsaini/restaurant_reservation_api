class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps
  field :time, type: String
  field :guest_count, type: Integer

  include ActiveModel::Validations
  after_save :init_email_sending_service
  belongs_to :restaurant
  belongs_to :shift
  belongs_to :table
  embeds_one :guest
  accepts_nested_attributes_for :guest

  validates_presence_of :time, :guest_count, :guest
  validates :time_before_type_cast, time: true
  validate :table_guest_count, if: :table
  validate :shift_time, if: :shift

  def shift
    @shift ||= restaurant.shifts.find(id: shift_id)
  end

  def table
    @table ||= restaurant.tables.find(id: table_id)
  end

  def init_email_sending_service
    ReservationEmailSendingService.new(self).perform
  end

  private

    def table_guest_count
      errors.add(:guest_count, :invalid_count, {minimum: table.minimum_guests, maximum: table.maximum_guests}) unless guest_count_valid?
    end

    def shift_time
      errors.add(:time, :invalid_time_slot, {start: shift.start, end: shift.end}) unless time_slot_valid?
    end

    def guest_count_valid?
      return guest_count >= table.minimum_guests && guest_count <= table.maximum_guests
    end

    def time_slot_valid?
      begin
        reservation_time = Time.parse(time)
        return reservation_time >= Time.parse(shift.start) && reservation_time <= Time.parse(shift.end)
      rescue
        return false
      end
    end

end
