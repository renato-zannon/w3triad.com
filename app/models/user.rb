class User < ActiveRecord::Base
  attr_accessor :password
  attr_protected :password_salt, :password_hash

  has_many :posts, :foreign_key => :author_id

  validates   :password, :confirmation => true, :presence => true
  validates   :email,    :email        => true, :presence => true
  validates   :name,     :presence     => true

  before_save :encrypt_password

  def has_valid_password?
    password_hash == encrypt(password)
  end

  def User.authenticate(email, password)
    user = User.find_by_email(email)
    user.password = password unless user.nil?
    return user if user && user.has_valid_password?
  end
  private

  def encrypt_password
    self.password_hash = encrypt(password)
  end

  def encrypt(pass)
    self.password_salt ||= BCrypt::Engine.generate_salt
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

end
