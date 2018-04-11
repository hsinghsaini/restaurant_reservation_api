class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :update, :destroy]

  def index
    @restaurants = Restaurant.all

    render json: @restaurants
  end

  def show
    render json: @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      render json: @restaurant, status: :created
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant.destroy
  end

  private
    def set_restaurant
      @restaurant = Restaurant.find_by(id: params[:id])
      render json: (I18n.t "restaurant.not_found"), status: :unprocessable_entity and return unless @restaurant
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :email, :phone, shifts_attributes: [:name , :start, :end], tables_attributes: [:name, :minimum_guests, :maximum_guests])
    end
end
