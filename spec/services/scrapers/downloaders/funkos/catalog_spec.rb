require 'rails_helper'

describe Scrapers::Downloaders::Funkos::Catalog, type: 'request' do
  describe '#call' do
    subject { Scrapers::Downloaders::Funkos::Catalog.new }
    
    it 'download teachers information' do
      subject.call
    end
  end

end
