# frozen_string_literal: true

FactoryBot.define do
  factory :choice do
    question
    choice { 'Sample choice' }
  end
end
