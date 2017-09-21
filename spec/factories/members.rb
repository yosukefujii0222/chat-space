FactoryGirl.define do
  factory :member do
    group_id
    user_id
    created_at { Faker::Time.between(2.days.ago, Time.now, :all) }
    updated_at { Faker::Time.between(1.days.ago, Time.now, :all) }
  end
end
