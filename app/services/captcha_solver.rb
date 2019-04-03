# frozen_string_literal: true

# Module to solve recaptchas
module CaptchaSolver
  API_KEY = ENV['ANTI_CAPTCHA_KEY']
  CAPTCHA_REQUEST_URL = 'http://2captcha.com/in.php'.freeze
  CAPTCHA_RESPONSE_URL = 'http://2captcha.com/res.php'.freeze
  SECONDS_TO_WAIT = 20

  class << self
    def solve_recaptcha(session, **options)
      puts 'Starting recaptcha solver'
      json_res = get_solver_response(options, session)

      puts "Recaptcha request id: #{json_res['request']}"

      return false if json_res['status'] == '0'

      puts "Waiting #{SECONDS_TO_WAIT} seconds..."
      sleep SECONDS_TO_WAIT

      process_recaptcha_answer(session, json_res)
    end

    private

    def get_solver_response(options, session)
      google_key = retrieve_google_key(session)
      params = recaptcha_options(google_key, session.current_url, **options)
      response = send_request(params, CAPTCHA_REQUEST_URL)
      JSON.parse(response.body)
    end

    def process_recaptcha_answer(session, json_res)
      captcha_response = request_recaptcha_answer(json_res['request'])

      return false if captcha_response['status'] == '0'

      input_recaptcha_token(session, captcha_response['request'])
      true
    end

    def recaptcha_options(google_key, page_url, **options)
      options.tap do
        options[:key] = API_KEY
        options[:method] = 'userrecaptcha'
        options[:googlekey] = google_key
        options[:pageurl] = page_url
        options[:json] = '1'
      end
    end

    def retrieve_google_key(session)
      div = session.find(:xpath, '//div[@data-sitekey]', visible: false)
      div['data-sitekey']
    end

    def input_recaptcha_token(session, token)
      js = 'document.getElementById("g-recaptcha-response")'
      js1 = js + '.style.display = null'
      js2 = js + '.style.display = "none"'

      session.execute_script(js1)
      session.fill_in('g-recaptcha-response', with: token)
      session.execute_script(js2)
    end

    def request_recaptcha_answer(id)
      puts 'Getting recaptcha answer...'
      loop do
        response = send_request(answer_options(id), CAPTCHA_RESPONSE_URL)
        json_res = JSON.parse(response.body)
        puts "Captcha answer: #{json_res['request']}"
        return json_res unless json_res['request'] == 'CAPCHA_NOT_READY'
        sleep 2
      end
    end

    def answer_options(id)
      {}.tap do |options|
        options[:key] = API_KEY
        options[:action] = 'get'
        options[:id] = id
        options[:json] = '1'
      end
    end

    def send_request(body, url)
      uri = URI(url)
      uri.query = URI.encode_www_form(body)
      Net::HTTP.get_response(uri)
    end
  end
end
