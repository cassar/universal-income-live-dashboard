class User < ApplicationRecord
  ADMIN_EMAIL = ENV['ADMIN_EMAIL'] || 'admin@email.com'.freeze

  # Include default devise modules. Others available are:
  # :recoverable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :confirmable

  has_one :member, dependent: :destroy

  after_create :create_member!

  def admin?
    email == ADMIN_EMAIL
  end
end
