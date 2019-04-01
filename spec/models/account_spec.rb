require 'rails_helper'

describe Account, type: :model do

  it 'should create a factory' do
    expect(FactoryBot.build(:account)).to be_valid
  end
end
