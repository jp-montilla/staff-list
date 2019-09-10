FactoryBot.define do
  factory :material do
    name { "Random Item" }
    material_type { "Hardware" }
    status {'Deployed'}
    employee { nil }
    
    trait :assigned do
      employee
    end
    
  end
end