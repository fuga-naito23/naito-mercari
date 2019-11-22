FactoryBot.define do
  factory :user do
    nickname { 'Alice' }
    sequence(:email) { |n| "test#{n}@gmail.com" }
    password { 'a' * 6 }
    password_confirmation { 'a' * 6 }
  end
end
