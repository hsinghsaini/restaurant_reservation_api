class ApplicationController < ActionController::API

  def set_restaurant
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    render json: (I18n.t "restaurant.not_found"), status: :unprocessable_entity and return unless @restaurant
  end

end
