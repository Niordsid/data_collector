module Scrapers::Helpers

  LOGIN_UD_URL = 'https://estudiantes.portaloas.udistrital.edu.co/appserv/index_urano.html'.freeze
  LOGIN_UM_URL = 'https://funcionarios.portaloas.udistrital.edu.co/urano/'.freeze
  LOGIN_UN_URL = 'https://siabog.unal.edu.co/academia/'.freeze


  def authenticate_account(session, user_account)
    case user_account.code
    when 'UD'
      authenticate_ud_credentials(session, user_account.decrypted_username, user_account.decrypted_password)
    when 'UN'
      authenticate_un_credentials(session, user_account.decrypted_username, user_account.decrypted_password)
    when 'UM'
      authenticate_um_credentials(session, user_account.decrypted_username, user_account.decrypted_password)
    end
  end

  private

  def authenticate_ud_credentials(session, username, password)
    session.visit(LOGIN_UD_URL)
    solve_recaptcha(session, tries: 10)
    session.find(:xpath, '//*[@id="nickname"]', wait: 5)
    session.fill_in 'nickname', with: username
    session.fill_in 'contrasena', with: password
    binding.pry
  end

  def solve_recaptcha
    while tries > 0
      break if CaptchaSolver.solve_recaptcha(session)
      tries -= 1
    end
  end
end
