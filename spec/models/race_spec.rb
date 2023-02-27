require 'rails_helper'

RSpec.describe Race, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:date)  }
    it { is_expected.to validate_presence_of(:place) }

    context 'when attributing a racer two different placements in the same race' do
      it 'rolls back the conflicting operation and notifies that a racer can occupy only one position per race' do

        racer = create(:racer)
        race = create(:race_with_tournament)

        race.add_racer_placement(racer.id, 1)
        race = race.add_racer_placement(racer.id, 2)

        expect(race.errors[:racer_id].first).to eq('A racer can occupy only one position per race!')
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:racers)     }
    it { is_expected.to belong_to(:tournament) }
  end
end
