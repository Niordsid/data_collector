require 'rails_helper'

describe Account, type: :model do
  subject { described_class.new }

  it 'should create an Account' do
    subject.code = '20101020089'
    subject.type = 'student'
    expect(subject).to be_valid
  end
end
