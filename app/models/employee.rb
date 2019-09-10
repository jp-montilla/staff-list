class Employee < ApplicationRecord
  has_many :answer, dependent: :destroy
  has_many :material

  # validates :email, uniqueness: { case_sensitive: false }
  validates :username, uniqueness: true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
