module Scrapers::Helpers

  CONDOR_URL = 'https://estudiantes.portaloas.udistrital.edu.co/appserv/'.freeze

  def authenticate_account(session, user_account)
    session.visit(CONDOR_URL)
    session.fill_in 'username', with: user_account.decrypted_username
    session.fill_in 'password', with: user_account.decrypted_password
  end

end
