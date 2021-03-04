FactoryBot.define do
  factory :user do
    password = Faker::Internet.password

    fullname { Faker::Name.name_with_middle }
    surname { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
  end
end
