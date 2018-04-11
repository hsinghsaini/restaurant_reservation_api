require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  subject(:restaurant) { FactoryBot.create(:restaurant) }

  it "has a valid factory" do
    expect( restaurant ).to be_valid
  end

  it 'is invalid without a name' do
    expect( FactoryBot.build(:restaurant, name: nil) ).to_not be_valid
  end

  it 'is invalid without an email' do
    expect( FactoryBot.build(:restaurant, email: nil) ).to_not be_valid
  end

  it 'is invalid for an invalid email' do
    expect( FactoryBot.build(:restaurant, email: "abc") ).to_not be_valid
  end

  it 'is invalid without a phone' do
    expect( FactoryBot.build(:restaurant, phone: nil) ).to_not be_valid
  end

  it 'is invalid for an invalid phone' do
    expect( FactoryBot.build(:restaurant, phone: "11111111") ).to_not be_valid
  end

  it 'is invalid if an email is not unique' do
    restaurant
    expect( FactoryBot.build(:restaurant) ).to_not be_valid
  end

  it 'returns an array of associated tables' do
    FactoryBot.create(:table1, restaurant: restaurant)
    FactoryBot.create(:table2, restaurant: restaurant)
    expect( restaurant.tables.count ).to eq(2)
  end

  it 'returns an array of associated shifts' do
    FactoryBot.create(:shift1, restaurant: restaurant)
    FactoryBot.create(:shift2, restaurant: restaurant)
    expect( restaurant.shifts.count ).to eq(2)
  end

end
