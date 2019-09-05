class Employee < ApplicationRecord
  has_many :answer, dependent: :destroy
  # has_many :assigned
  # has_many :material, through: :assigned
  has_many :material



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
