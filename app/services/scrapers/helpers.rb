module Scrapers::Helpers

  CONDOR_URL = 'https://estudiantes.portaloas.udistrital.edu.co/appserv/'.freeze

  def authenticate_account(session, user_account)
    session.visit(CONDOR_URL)
    session.find(:xpath, '//*[@id="nickname"]', wait: 5)
    session.fill_in 'nickname', with: user_account.decrypted_username
    session.fill_in 'contrasena', with: user_account.decrypted_password
  end

end
