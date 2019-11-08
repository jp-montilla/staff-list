# frozen_string_literal: true

# Answer Model
class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :employee

  validates :answer, presence: true
  validates_length_of :answer, maximum: 255
end
