class User < ActiveRecord::Base
  attr_writer :password
  attr_protected :password_salt, :password_hash

  validates   :password, :confirmation => true, :presence => true
  validates   :email,    :email        => true, :presence => true
  validates   :name,     :presence     => true

  before_save :encrypt_password

  def has_valid_password?
    password_hash == encrypt(password)
  end

  private

  def encrypt_password
    self.password_hash = encrypt(password)
  end

  def encrypt(pass)
    self.password_salt ||= BCrypt::Engine.generate_salt
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  def password
    @password
  end

end
