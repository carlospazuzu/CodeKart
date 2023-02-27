require 'ffaker'

FactoryBot.define do
  factory :race do
    date  { FFaker::Time.date      }
    place { FFaker::AddressBR.city }
    tournament

    factory :race_with_tournament do
      association :tournament, factory: :tournament
    end

  end
end
