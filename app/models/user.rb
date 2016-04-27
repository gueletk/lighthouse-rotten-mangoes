class User < ActiveRecord::Base
  paginates_per 5
  has_secure_password

  has_many :reviews

  def full_name
    "#{firstname} #{lastname}"
  end

  def admin?
    admin
  end

end
