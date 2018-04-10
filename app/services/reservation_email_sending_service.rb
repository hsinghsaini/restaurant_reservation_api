class ReservationEmailSendingService

  def initialize(reservation)
    @reservation = reservation
  end

  def perform
    @reservation._id_changed? ? send_new_reservation_emails : send_update_reservation_emails
  end

  private

    def send_new_reservation_emails
      GuestMailer.delay.reservation_confirm_email(@reservation.id.to_s)
      RestaurantMailer.delay.reservation_confirm_email(@reservation._id)
    end

    def send_update_reservation_emails
      GuestMailer.delay.reservation_updated_email(@reservation.id.to_s, @reservation.changed_attributes)
      RestaurantMailer.delay.reservation_updated_email(@reservation.id.to_s, @reservation.changed_attributes)
    end

end
