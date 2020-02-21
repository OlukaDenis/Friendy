FactoryBot.define do
  factory :user do
    email { 'test@gmail.com' }
    password { 'secret' }
    password_confirmation { 'secret' }
    name { 'mcdenny' }
  end
end
