require 'rails_helper'

RSpec.describe ShiftsController, type: :controller do
  let(:restaurant) { FactoryBot.create(:restaurant) }
  subject(:shift) { FactoryBot.create(:shift1, restaurant: restaurant) }

  let(:valid_attributes) {
    {
      name: "Morning",
      start: "9:00",
      end: "13:00",
      restaurant: restaurant
    }
  }

  let(:invalid_attributes) {
    {
      name: "Evening",
      start: "abc",
      end: "23:00"
    }
  }


  describe "GET #index" do
    it "returns a success response" do
      shift
      get :index, params: {restaurant_id: restaurant.to_param}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      shift
      get :show, params: {restaurant_id: restaurant.to_param, id: shift.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Shift" do
        post :create, params: {restaurant_id: restaurant.to_param, shift: valid_attributes}
        restaurant.reload
        expect( restaurant.shifts.count ).to eq(1)
      end

      it "renders a JSON response with the new shift" do
        post :create, params: {restaurant_id: restaurant.to_param, shift: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new shift" do
        post :create, params: {restaurant_id: restaurant.to_param, shift: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: "New Morning"
        }
      }

      it "updates the requested shift" do
        shift
        put :update, params: {restaurant_id: restaurant.to_param, id: shift.to_param, shift: new_attributes}
        shift.reload
        expect(shift.name).to eq(new_attributes[:name])
      end

      it "renders a JSON response with the shift" do
        shift
        put :update, params: {restaurant_id: restaurant.to_param, id: shift.to_param, shift: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the shift" do
        shift
        put :update, params: {restaurant_id: restaurant.to_param, id: shift.to_param, shift: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested shift" do
      shift
      delete :destroy, params: {restaurant_id: restaurant.to_param, id: shift.to_param}
      restaurant.reload
      expect( restaurant.shifts.count ).to eq(0)
    end
  end

end
