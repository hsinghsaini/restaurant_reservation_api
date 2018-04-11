require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  subject(:restaurant) { FactoryBot.create(:restaurant) }

  let(:valid_attributes) {
    {
      name: "One",
      phone: 1234567809,
      email: 'ccc@bbb.com'
    }
  }

  let(:invalid_attributes) {
    {
      name: "One",
      phone: 1111111111,
      email: 'abcom'
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      restaurant
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      restaurant
      get :show, params: {id: restaurant.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Restaurant" do
        expect {
          post :create, params: {restaurant: valid_attributes}
        }.to change(Restaurant, :count).by(1)
      end

      it "renders a JSON response with the new restaurant" do
        post :create, params: {restaurant: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new restaurant" do
        post :create, params: {restaurant: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: "Restaurant One"
        }
      }

      it "updates the requested restaurant" do
        restaurant
        put :update, params: {id: restaurant.to_param, restaurant: new_attributes}
        restaurant.reload
        expect(restaurant.name).to eq(new_attributes[:name])
      end

      it "renders a JSON response with the restaurant" do
        restaurant
        put :update, params: {id: restaurant.to_param, restaurant: new_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the restaurant" do
        restaurant
        put :update, params: {id: restaurant.to_param, restaurant: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested restaurant" do
      restaurant
      expect {
        delete :destroy, params: {id: restaurant.to_param}
      }.to change(Restaurant, :count).by(-1)
    end
  end

end
