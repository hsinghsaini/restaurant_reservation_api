require 'rails_helper'

RSpec.describe TablesController, type: :controller do
  let(:restaurant) { FactoryBot.create(:restaurant) }
  subject(:table) { FactoryBot.create(:table1, restaurant: restaurant) }

  let(:valid_attributes) {
    {
      name: "T1",
      minimum_guests: 3,
      maximum_guests: 5,
      restaurant: restaurant
    }
  }

  let(:invalid_attributes) {
    {
      name: "T1",
      minimum_guests: -10,
      maximum_guests: 5
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      table
      get :index, params: {restaurant_id: restaurant.to_param}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      table
      get :show, params: {restaurant_id: restaurant.to_param, id: table.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Table" do
        post :create, params: {restaurant_id: restaurant.to_param, table: valid_attributes}
        restaurant.reload
        expect( restaurant.tables.count ).to eq(1)
      end

      it "renders a JSON response with the new table" do
        post :create, params: {restaurant_id: restaurant.to_param, table: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new table" do
        post :create, params: {restaurant_id: restaurant.to_param, table: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: "New T1"
        }
      }

      it "updates the requested table" do
        table
        put :update, params: {restaurant_id: restaurant.to_param, id: table.to_param, table: new_attributes}
        table.reload
        expect(table.name).to eq(new_attributes[:name])
      end

      it "renders a JSON response with the table" do
        table
        put :update, params: {restaurant_id: restaurant.to_param, id: table.to_param, table: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the table" do
        table
        put :update, params: {restaurant_id: restaurant.to_param, id: table.to_param, table: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested table" do
      table
      delete :destroy, params: {restaurant_id: restaurant.to_param, id: table.to_param}
      restaurant.reload
      expect( restaurant.tables.count ).to eq(0)
    end
  end

end
