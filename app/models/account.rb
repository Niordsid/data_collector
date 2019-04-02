class Account < ApplicationRecord

  self.inheritance_column = 'sti_type'

  validates_presence_of :code, :type

  def set_credentials(username, password)
    (1..10).each {|i| self.write_attribute( "base_token_#{i}0", encrypt_data(random_touple)) }
    self.write_attribute(ENV['CREDENTIALS_BASE_TOKEN'], encrypt_data("#{username},#{password}"))
  end

  def decrypted_username
    decrypted_touple.split(',')[0]
  end

  def decrypted_password
    decrypted_touple.split(',')[1]
  end

  private

  def decrypted_touple
    crypt = ActiveSupport::MessageEncryptor.new(Base64.decode64(ENV['ENCODED_KEY']))
    crypt.decrypt_and_verify(self.send(ENV['CREDENTIALS_BASE_TOKEN']))
  end

  def random_touple
    "#{Faker::Number.number(9)},#{Faker::Number.number(7)}"
  end

  def encrypt_data(touple)
    salt = Base64.decode64 ENV['ENCODED_SALT'] # We save the value of: SecureRandom.random_bytes(64)
    key = Base64.decode64 ENV['ENCODED_KEY']  # We save the value of: ActiveSupport::KeyGenerator.new('password').generate_key(salt)
    crypt = ActiveSupport::MessageEncryptor.new(key)
    encrypted_data = crypt.encrypt_and_sign(touple)
  end
end
