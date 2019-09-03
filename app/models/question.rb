class Question < ApplicationRecord
  has_many :choice, dependent: :destroy
  has_one :answer, dependent: :destroy
end
