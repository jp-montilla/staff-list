class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :employee

  # validates :answer, presence: true
end
