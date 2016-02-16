class User < ActiveRecord::Base
	#attr_accessible :username,:email, :password, :password_confirmation
  belongs_to :team
  has_many :ratings
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_length_of :password, :in => 6..20
  validates_presence_of :password, :on => :create

  validates_presence_of :username
  validates_uniqueness_of :username
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, :uniqueness => true, format: { with: VALID_EMAIL_REGEX }


  
  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
