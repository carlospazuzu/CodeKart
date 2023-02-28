require 'ffaker'

FactoryBot.define do
  factory :racer do
    name      { FFaker::Name.name }
    born_at   { FFaker::Time.between(Date.new(1970, 1, 1), Date.new(2000, 1, 1)) }
    image_url { FFaker::Image.url }

    trait :underaged do
      born_at { 14.years.ago }
    end
  end
end
