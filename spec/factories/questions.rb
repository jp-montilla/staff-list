FactoryBot.define do
  factory :question do
    question { "Sample question" }
    answer_type { "Text" }
    view_to_list { 0 }

    trait :view do
      view_to_list { 1 }
    end    
  end
end