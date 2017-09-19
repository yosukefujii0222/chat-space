FactoryGirl.define do
  factory :group do
    groupname  Faker::Name.name
    created_at { Faker::Time.between(3.days.ago, Time.now, :all) }
    updated_at { Faker::Time.between(2.days.ago, Time.now, :all) }
  end
end
