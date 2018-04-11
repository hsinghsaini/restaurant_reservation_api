require 'rails_helper'

RSpec.describe Guest, type: :model do

  it 'is invalid without a name' do
    expect( FactoryBot.build(:guest, name: nil) ).to_not be_valid
  end

  it 'is invalid without an email' do
    expect( FactoryBot.build(:guest, email: nil) ).to_not be_valid
  end

  it 'is invalid for an invalid email' do
    expect( FactoryBot.build(:guest, email: "abc") ).to_not be_valid
  end

end
