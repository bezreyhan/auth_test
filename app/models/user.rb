class User < ActiveRecord::Base

  validates :email, uniqueness: true
  validates :email, presence: true, length: {minimum: 6}


  attr_accessor :password

  def authenticated? pwd
    self.hashed_password == BCrypt::Engine.hash_secret(pwd, self.salt)
  end

  before_save :hash_the_password
  private

  def hash_the_password 
    unless self.password == nil
      self.salt = BCrypt::Engine.generate_salt
      self.hashed_password = BCrypt::Engine.hash_secret self.password, self.salt
      self.password = nil
    end
  end

end
