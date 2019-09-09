FactoryBot.define do
  factory :employee do
    email { "test@example.com" }
    password { "password" }

    trait :user do
      role { "Employee" }
    end
    trait :admin do
      role { "Admin" }
    end
  end
end