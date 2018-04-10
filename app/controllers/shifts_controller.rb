class ShiftsController < ApplicationController
  before_action :set_restaurant
  before_action :set_shift, only: [:show, :update, :destroy]

  def index
    @shifts = @restaurant.shifts

    render json: @shifts
  end

  def show
    render json: @shift
  end

  def create
    @shift = @restaurant.shifts.new(shift_params)

    if @shift.save
      render json: @shift, status: :created
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  def update
    if @shift.update(shift_params)
      render json: @shift
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @shift.destroy
  end

  private
    def set_shift
      @shift = @restaurant.shifts.find_by(id: params[:id])
      render json: (I18n.t "shift.not_found"), status: :unprocessable_entity and return unless @shift
    end

    def shift_params
      params.require(:shift).permit(:name, :start, :end)
    end
end
