require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:restaurant) { FactoryBot.create(:restaurant) }
  let(:table) { FactoryBot.create(:table1, restaurant: restaurant) }
  let(:shift) { FactoryBot.create(:shift1, restaurant: restaurant) }
  let(:guest) { FactoryBot.build(:guest) }

  subject(:reservation) { FactoryBot.create(:reservation, restaurant: restaurant, table: table, shift: shift, guest: guest)}

  it 'has a valid factory' do
    expect( reservation ).to be_valid
  end

  it 'is invalid without time' do
    expect( FactoryBot.build(:reservation, time: nil, restaurant: restaurant, table: table, shift: shift, guest: guest)).to_not be_valid
  end

  it 'is invalid for invalid time' do
    expect( FactoryBot.build(:reservation, time: "abc", restaurant: restaurant, table: table, shift: shift, guest: guest)).to_not be_valid
  end

  it 'is invalid if time slot is outside shift timings' do
    expect( FactoryBot.build(:reservation, time: "16:00", restaurant: restaurant, table: table, shift: shift, guest: guest)).to_not be_valid
  end

  it 'is invalid without guest_count' do
    expect( FactoryBot.build(:reservation, guest_count: nil, restaurant: restaurant, table: table, shift: shift, guest: guest)).to_not be_valid
  end

  it 'is invalid for invalid guest_count' do
    expect( FactoryBot.build(:reservation, guest_count: -10, restaurant: restaurant, table: table, shift: shift, guest: guest)).to_not be_valid
  end

  it 'is invalid for guest_count greater than the table maximum_guests' do
    expect( FactoryBot.build(:reservation, guest_count: 6, restaurant: restaurant, table: table, shift: shift, guest: guest)).to_not be_valid
  end

  it 'is invalid without guest' do
    expect( FactoryBot.build(:reservation, guest_count: 6, restaurant: restaurant, table: table, shift: shift, guest: nil)).to_not be_valid
  end

  it 'is invalid for invalid guest' do
    guest = FactoryBot.build(:guest, name: nil)
    expect( FactoryBot.build(:reservation, guest_count: 6, restaurant: restaurant, table: table, shift: shift, guest: guest)).to_not be_valid
  end

  it 'is invalid without table' do
    expect( FactoryBot.build(:reservation, restaurant: restaurant, table: nil, shift: shift, guest: guest)).to_not be_valid
  end

  it 'is invalid without shift' do
    expect( FactoryBot.build(:reservation, restaurant: restaurant, table: table, shift: nil, guest: guest)).to_not be_valid
  end

end
