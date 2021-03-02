FactoryBot.define do
  factory :user do
    fullname { Faker::Name.name_with_middle }
    surname { Faker::Name.first_name }
    email { Faker::Internet.email }
  end
end