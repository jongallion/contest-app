FactoryBot.define do
  factory :contest_entry do
    user_id     { "#{SecureRandom.hex(6)}" }
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    email       { Faker::Internet.email }
  end
end
