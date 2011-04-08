class User < ActiveRecord::Base
  attr_accessor :password, :new_password
  attr_protected :password_salt, :password_hash

  has_many :posts, :foreign_key => :author_id

  validates_presence_of :nickname, :email, :name, :password
  validates_confirmation_of :password,              :on => :create
  validates_presence_of :password_confirmation,     :on => :create
  validates_confirmation_of :new_password
  validates_presence_of :new_password_confirmation, :on => :update, :unless => Proc.new { new_password.nil? or new_password.empty? }
  validates_uniqueness_of :email, :nickname
  validates :email, :email => true

  before_save   :encrypt_password
  validate(:check_password, :on => :update)

  def has_valid_password?
    self.password_hash == encrypt(self.password)
  end

  def User.authenticate(nickname, password)
    user = User.with_nickname(nickname)
    user.password = password unless user.nil?
    return user if user && user.has_valid_password?
  end

  def User.with_nickname(nickname)
    find(:first, :conditions => ["lower(?) = lower(users.nickname)", nickname])
  end

  private
  def encrypt_password
    self.password = self.new_password unless self.new_password.nil? or self.new_password.empty?
    self.password_hash = encrypt(self.password)
  end

  def encrypt(pass)
    self.password_salt ||= BCrypt::Engine.generate_salt
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  def check_password
    self.errors[:password] << "not valid!" unless has_valid_password?
  end
end
