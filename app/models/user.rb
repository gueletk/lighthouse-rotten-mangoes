class User < ActiveRecord::Base
  paginates_per 10
  has_secure_password

  has_many :reviews

  def full_name
    "#{firstname} #{lastname}"
  end

  def admin?
    admin
  end

end
