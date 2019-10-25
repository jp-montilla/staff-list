class Employee < ApplicationRecord
  # devise :session_limitable
  has_many :answer, dependent: :destroy
  has_many :material, dependent: :nullify

  mount_uploader :profile_picture, ProfilePictureUploader
  validates :profile_picture, file_size: { less_than: 1.megabytes }

  validates :name, presence: true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :session_limitable, :registerable,
         :recoverable, :rememberable, :validatable
end
