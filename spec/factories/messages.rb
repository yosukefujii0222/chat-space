FactoryGirl.define do
  factory :message do
    body        Faker::Lorem.sentence
    image       Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test/image.jpg'))
    group
    user
    created_at  { Faker::Time.between(3.days.ago, Time.now, :all) }
    updated_at  { Faker::Time.between(2.days.ago, Time.now, :all) }
  end
end

