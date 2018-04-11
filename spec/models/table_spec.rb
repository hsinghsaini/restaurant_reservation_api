require 'rails_helper'

RSpec.describe Table, type: :model do
  let(:restaurant) { FactoryBot.create(:restaurant) }
  subject(:table) { FactoryBot.create(:table1) }

  it 'has a valid factory' do
    expect( table ).to be_valid
  end

  it 'is invalid without a name' do
    expect( FactoryBot.build(:table1, name: nil) ).to_not be_valid
  end

  it 'is invalid is a name is not unique' do
    FactoryBot.create(:table1, restaurant: restaurant)
    expect( FactoryBot.build(:table1, restaurant: restaurant) ).to_not be_valid
  end

  it 'is invalid without a minimum_guests' do
    expect( FactoryBot.build(:table1, minimum_guests: nil) ).to_not be_valid
  end

  it 'is invalid for an invalid minimum_guests' do
    expect( FactoryBot.build(:table1, minimum_guests: -10) ).to_not be_valid
  end

  it 'is invalid without a maximum_guests' do
    expect( FactoryBot.build(:table1, maximum_guests: nil) ).to_not be_valid
  end

  it 'is invalid for an invalid maximum_guests' do
    expect( FactoryBot.build(:table1, maximum_guests: "abc") ).to_not be_valid
  end

  it 'is invalid for an valid maximum_guests but less than minimum_guests' do
    expect( FactoryBot.build(:table1, maximum_guests: 1) ).to_not be_valid
  end

end
