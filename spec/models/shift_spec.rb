require 'rails_helper'

RSpec.describe Shift, type: :model do
  let(:restaurant) { FactoryBot.create(:restaurant) }
  subject(:shift) { FactoryBot.create(:shift1) }

  it 'has a valid factory' do
    expect( shift ).to be_valid
  end

  it 'is invalid without a name' do
    expect( FactoryBot.build(:shift1, name: nil) ).to_not be_valid
  end

  it 'is invalid if a name is not unique' do
    FactoryBot.create(:shift1, restaurant: restaurant)
    expect( FactoryBot.build(:shift1, restaurant: restaurant) ).to_not be_valid
  end

  it 'is invalid without a start' do
    expect( FactoryBot.build(:shift1, start: nil) ).to_not be_valid
  end

  it 'is invalid for an invalid start' do
    expect( FactoryBot.build(:shift1, start: "abc") ).to_not be_valid
  end

  it 'is invalid without a end' do
    expect( FactoryBot.build(:shift1, end: nil) ).to_not be_valid
  end

  it 'is invalid for an invalid end' do
    expect( FactoryBot.build(:shift1, end: "abc") ).to_not be_valid
  end

  it 'is invalid for an valid end but before start' do
    expect( FactoryBot.build(:shift1, end: "1:00") ).to_not be_valid
  end

end
