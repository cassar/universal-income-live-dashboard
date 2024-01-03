class User < ApplicationRecord
  ADMIN_EMAIL = ENV['ADMIN_EMAIL'] || 'admin@email.com'.freeze
  ADMIN_PASSWORD = 'password'.freeze

  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_one :member, dependent: :destroy

  after_create :create_member!

  def admin?
    email == ADMIN_EMAIL
  end
end
