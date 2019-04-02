require 'rails_helper'

describe Scrapers::Downloaders::Teachers::Condor, type: 'request' do
  describe '#call' do
    subject { Scrapers::Downloaders::Teachers::Condor.new(account) }

    let(:account) do
      Account.create(code: ENV['CONDOR_USERNAME'], type: 'student')
    end

    before do
      account.set_credentials(ENV['CONDOR_USERNAME'], ENV['CONDOR_PSS'])
    end


    it 'download teachers information' do
      subject.call
    end
  end

end

