# frozen_string_literal: true

# Choice Model
class Choice < ApplicationRecord
  belongs_to :question

  validates :choice, presence: true
end
