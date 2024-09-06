class User < ApplicationRecord
  validates_uniqueness_of :username

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :extract_name_from_email

  private

  def extract_name_from_email
    self.username ||= email.match(/^[^0-9]+/).to_s.strip
  end
end