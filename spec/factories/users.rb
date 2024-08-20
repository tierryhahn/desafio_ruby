FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      email { Faker::Internet.unique.email }
      password { 'password' }
      password_confirmation { 'password' }
      otp_secret { ROTP::Base32.random_base32 }
    end
  end