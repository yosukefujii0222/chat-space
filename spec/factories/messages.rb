FactoryGirl.define do
  factory :message do
    body      "test"
    user_id   1
    group_id  1
    image     "test.jpeg"
    created_at { Faker::Time.between(2.days.ago, Time.now, :all) }
  end
end
