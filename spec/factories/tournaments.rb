require 'ffaker'

FactoryBot.define do
  factory :tournament do
    name { "#{FFaker::BaconIpsum.word.capitalize} Tournament" }

    factory :tournament_with_races do
      transient do
        races_count { 5 }
      end

      after(:create) do |tournament, evaluator|
        create_list(:race, evaluator.races_count, tournament: tournament)
        tournament.reload
      end
    end
  end
end
