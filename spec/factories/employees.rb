FactoryBot.define do
  factory :employee do
    email { "test@example.com" }
    username { "username" }
    password { "password" }
    password_confirmation { "password" }
    role { "Employee" }
    
    trait :admin do
      role { "Admin" }
    end
  end
end