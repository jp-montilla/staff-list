class Choice < ApplicationRecord
  belongs_to :question

  # validates :question, presence: true
  validates :choice, presence: true
end
