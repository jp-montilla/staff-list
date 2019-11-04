# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    question
    employee
    answer { 'Sample Answer' }

    # trait :other1 do
    #   association :employee, :other1
    # end
    # trait :other2 do
    #   association :employee, :other2
    #   answer { 2 }
    # end
    # trait :other3 do
    #   association :employee, :other3
    #   answer { "Sample Choice" }
    # end
  end
end
