require 'capybara/dsl'

class Scrapers::Downloaders::Funkos::Base < ActiveModelService
  include Capybara::DSL
  include Scrapers::Helpers

  CONDOR_URL = 'https://www.funko.com/products'.freeze

  attr_accessor :setup, :session, :response, :path


  def initialize(options={})
    @response = {}
    @path = "#{ Rails.root  }/tmp/downloads/funko"
    @setup = Scrapers::Setup.new.call(type: :firefox, folder_path: path)
    @session = @setup.session
  end


  def call(options={})
    download_information
  end
end
