FactoryGirl.define do
  pass = Faker::Internet.password(8)

  factory :user do
    name                  Faker::Name.name
    email                 Faker::Internet.email
    password              pass
    password_confirmation pass
    created_at { Faker::Time.between(2.days.ago, Time.now, :all) }
    updated_at { Faker::Time.between(1.days.ago, Time.now, :all) }
  end
end
