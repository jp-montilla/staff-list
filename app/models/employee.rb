class Employee < ApplicationRecord
  has_many :answer, dependent: :destroy
  has_many :material, dependent: :nullify

  mount_uploader :profile_picture, ProfilePictureUploader

  validates :name, uniqueness: true
  validates :name, presence: true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
