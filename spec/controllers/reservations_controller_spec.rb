require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  let(:restaurant) { FactoryBot.create(:restaurant) }
  let(:table) { FactoryBot.create(:table1, restaurant: restaurant) }
  let(:shift) { FactoryBot.create(:shift1, restaurant: restaurant) }
  let(:guest) { FactoryBot.build(:guest) }
  subject(:reservation) { FactoryBot.create(:reservation, restaurant: restaurant, table: table, shift: shift, guest: guest) }


  let(:valid_attributes) {
    {
      time: "11:00",
      guest_count: 4,
      restaurant: restaurant,
      table_id: table.to_param,
      shift_id: shift.to_param,
      guest_attributes: {
        name: guest.name,
        email: guest.email
      }
    }
  }

  let(:invalid_attributes) {
    {
      time: "abc",
      guest_count: 4,
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      reservation
      get :index, params: {restaurant_id: restaurant.to_param}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      reservation
      get :show, params: {restaurant_id: restaurant.to_param, id: reservation.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Reservation" do
        post :create, params: {restaurant_id: restaurant.to_param, reservation: valid_attributes}
        restaurant.reload
        expect( restaurant.reservations.count ).to eq(1)
      end

      it "renders a JSON response with the new reservation" do
        post :create, params: {restaurant_id: restaurant.to_param, reservation: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new reservation" do
        post :create, params: {restaurant_id: restaurant.to_param, reservation: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          guest_count: 3
        }
      }

      it "updates the requested reservation" do
        reservation
        put :update, params: {restaurant_id: restaurant.to_param, id: reservation.to_param, reservation: new_attributes}
        reservation.reload
        expect(reservation.guest_count).to eq(new_attributes[:guest_count])
      end

      it "renders a JSON response with the reservation" do
        reservation
        put :update, params: {restaurant_id: restaurant.to_param, id: reservation.to_param, reservation: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the reservation" do
        reservation
        put :update, params: {restaurant_id: restaurant.to_param, id: reservation.to_param, reservation: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested reservation" do
      reservation
      delete :destroy, params: {restaurant_id: restaurant.to_param, id: reservation.to_param}
      restaurant.reload
      expect(restaurant.reservations.count).to eq(0)
    end
  end

end
