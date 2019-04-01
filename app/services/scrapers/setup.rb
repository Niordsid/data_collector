# Setup class to create invoice provider scraper objects
class Scrapers::Setup

  attr_accessor :session

  def initialize(opts={})
  end

  def call(options={})
    type = options[:type] || :default
    url_service = options[:url_service] || "http://selenium:4444/wd/hub"
    case type
    when :no_proxy
      session = Capybara::Session.new(:firefox_headless)
      @session = session
    when :default
      session = Capybara::Session.new(:pg_billy)
      session.driver.headers = { 'User-Agent' => 'Mozilla/4.6 [en] (WinNT; I)' }
      # NOTE: this was comment out because proxy server was shut down until we test thsi
      # with more request. It mean that we are working on production without any proxy.
      #session.driver.set_proxy(ENV['PROXY_URL'], ENV['PROXY_PORT'].to_i, 'http', ENV['PROXY_USER'], ENV['PROXY_PASSWORD'])
      @session = session
    when :chrome
      # NOTE: the next command is in order to make sure that a Xvfb is started in the background
      # NOTE: this was comment out because proxy server was shut down until we test thsi
      # with more request. It mean that we are working on production without any proxy.
      FileUtils.mkdir_p(options[:folder_path])
      driver_name = Time.now.to_i
      Capybara.register_driver "chrome_#{ driver_name }" do |app|
        Capybara.app_host = "http://google.com"
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-gpu')
        options.add_argument('--screen-size=1200x800')
        options.add_argument('--remote-debugging-port=9222')
        options.add_argument('--ntp-snippets-add-incomplete')
        options.add_argument('--safebrowsing-disable-download-protection')
        options.add_preference(:download, directory_upgrade: true,
          prompt_for_download: false, default_directory: @path
        )
        Capybara::Selenium::Driver.new(
          app, browser: :chrome, options: options
        )
      end
      @session = Capybara::Session.new("chrome_#{ driver_name }")
    when :firefox
      FileUtils.mkdir_p(options[:folder_path])
      dir_permissions
      driver_name = Time.now.to_i
      Capybara.register_driver "firefox_#{ driver_name }".to_sym do |app|
       #Capybara.app_host = "http://google.com"
        Selenium::WebDriver::Firefox::Binary.path = ENV['CUSTOM_FF_PATH'] if ENV['CUSTOM_FF_PATH'].present?
        profile = Selenium::WebDriver::Firefox::Profile.new
        profile.assume_untrusted_certificate_issuer = ENV['SKIP_CERT_ISSUER'].present?
        profile['browser.download.folderList'] = 2 # implies custom location
        profile['browser.download.dir'] = options[:folder_path]
        profile['browser.helperApps.alwaysAsk.force'] = false
        profile['browser.download.manager.showWhenStarting'] = false
        profile['browser.helperApps.neverAsk.saveToDisk'] = "text/GZ,text/gzip,application/gzip,application/GZ,application/tar+gzip, application/x-compressed,application/csv+GZ,application/blob,application/json,text/plain,*/*,application/xls,application/octet-stream, text/plain, application/vnd.ms-excel, text/csv, text/comma-separated-values, application/octet-stream,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,text/csv GZ,application/csv GZ,/csv GZ, /tgz,text/*,application/*,application/x-gnumeric,text/x-csv.GZ,application/x-csv.GZ,text/x-gzip GZ,application/x-GZ,application/x-GZ,application/x-gzip,text/csv,application/tar,text/zip,application/zip,application/pdf,*/pdf,application/doc,application/docx,image/jpeg,text/csv, text/.csv.GZ, application/.csv.GZ, text/GZ, application/GZ, application/csv, text/comma-separated-values, application/download, application/octet-stream, binary/octet-stream, application/binary, application/x-unknown, pfx"
        profile["pdfjs.disabled"] = true
        profile["security.default_personal_cert"] = "Select Automatically"
        profile.assume_untrusted_certificate_issuer=false
        profile.native_events = true
        client = Selenium::WebDriver::Remote::Http::Default.new
        client.read_timeout = 300
        options = Selenium::WebDriver::Firefox::Options.new
        #NOTE remove this flags when docker development will be complete
        options.add_argument('--headless') if APP_CONFIG[:SCRAPER_HEADLESS]
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-gpu')
        options.add_argument('--screen-size=1200x800')
        options.add_argument('--network.http.max-persistent-connections-per-server=20')
        options.profile = profile
############
##########
        Capybara.javascript_driver = "firefox_#{ driver_name }".to_sym
        #NOTE remove this flags when docker development will be complete
        APP_CONFIG[:DOCKER_SELENIUM] ? setup_driver_to_docker(app, options, client, url_service) : setup_default_driver(app, options, client)
      end
      @session = Capybara::Session.new("firefox_#{ driver_name }".to_sym)
    else
      raise "This #{ type } is not sopported"
    end

    return self
  end

  private

  def setup_driver_to_docker(app, options, client, url_service)
    Capybara::Selenium::Driver.new(
      app,
      browser: :firefox,
      http_client: client,
      options: options,
      url: url_service
    )
  end

  def setup_default_driver(app, options, client)
    Capybara::Selenium::Driver.new(
      app,
      browser: :firefox,
      options: options,
      http_client: client
    )
  end

  def dir_permissions
    `chown -R 1000:1000 /data_collector/tmp/`
  end
end
