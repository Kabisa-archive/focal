FactoryGirl.define do
  factory :admin_user do
    email { sequence { |i| "admin-#{i}@example.com" } }
    password "password"
    password_confirmation { |attrs| attrs[:password] }
  end
end
