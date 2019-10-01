FactoryBot.define do
  factory :employee do
    profile_picture { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/avatar.png'), 'image/png') }
    email { "something@example.com" }
    name { "something" }
    password { "password" }
    password_confirmation { "password" }
    role { "Employee" }
    
    trait :admin do
      email { "something2@example.com" }
      name { "something2" }
      role { "Admin" }
    end
  end
end