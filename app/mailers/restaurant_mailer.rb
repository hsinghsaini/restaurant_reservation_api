class RestaurantMailer < ApplicationMailer

  def reservation_confirm_email(reservation_id)
    @reservation = Reservation.find_by(id: reservation_id)
    mail(to: @reservation.restaurant.email, subject: "Reservation Confirmed")
  end

  def reservation_updated_email(reservation_id, changed_attributes)
    @reservation = Reservation.find_by(id: reservation_id)
    @changed_attributes = changed_attributes
    mail(to: @reservation.restaurant.email, subject: "#{@reservation.id} - Reservation Details Updated")
  end
end
