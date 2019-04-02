require 'capybara/dsl'

class Scrapers::Downloaders::Teachers::Base < ActiveModelService
  include Capybara::DSL
  include Scrapers::Helpers

  CONDOR_URL = 'https://estudiantes.portaloas.udistrital.edu.co/appserv/'.freeze

  attr_accessor :setup, :session, :response, :path, :user_account


  def initialize(user_account, options={})
    @response = {}
    @user_account = user_account
    unique_key = "#{user_account.id}-#{Time.now.to_i}-#{SecureRandom.hex(8)}"
    @path = "#{ Rails.root  }/tmp/downloads/#{unique_key}-teachers"
    @setup = Scrapers::Setup.new.call(type: :firefox, folder_path: path)
    @session = @setup.session
  end


  def call(options={})
    authenticate_account(session, user_account)
    download_information
  end
end
