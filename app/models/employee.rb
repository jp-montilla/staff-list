class Employee < ApplicationRecord
  has_many :answer, dependent: :destroy
  has_many :equipment, through: :assigned, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
