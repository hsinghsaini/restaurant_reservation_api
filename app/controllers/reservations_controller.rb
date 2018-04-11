class ReservationsController < ApplicationController
  before_action :set_restaurant
  before_action :set_reservation, only: [:show, :update, :destroy]

  def index
    @reservations = @restaurant.reservations

    render json: @reservations
  end

  def show
    render json: @reservation
  end

  def create
    @reservation = @restaurant.reservations.new(reservation_params)
    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def update
    if @reservation.update(reservation_update_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
  end

  private
    def set_reservation
      @reservation = @restaurant.reservations.find_by(id: params[:id])
      render json: (I18n.t "reservations.not_found"), status: :unprocessable_entity and return unless @reservation
    end

    def reservation_params
      params.require(:reservation).permit(:time, :guest_count, :table_id, :shift_id, guest_attributes: [:name, :email])
    end

    def reservation_update_params
      params.require(:reservation).permit(:time, :guest_count)
    end
end
