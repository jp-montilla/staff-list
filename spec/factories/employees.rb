FactoryBot.define do
  factory :employee do
    profile_picture { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/avatar.png'), 'image/png') }
    email { "test@example.com" }
    name { "username" }
    password { "password" }
    password_confirmation { "password" }
    role { "Employee" }
    
    trait :admin do
      role { "Admin" }
    end
  end
end