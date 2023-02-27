require 'rails_helper'

RSpec.describe Placement, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:position) }

    context 'when trying to register the same pilot in two different positions' do
      it 'rolls back the conflicting operation and notify that a racer can occupy only one position per race' do
        race = create(:race)
        racer = create(:racer)
        Placement.create({ race_id: race.id, racer_id: racer.id, position: 1 })
        result = Placement.create({ race_id: race.id, racer_id: racer.id, position: 2 })
        expect(result.errors[:racer_id].first).to eq('A racer can occupy only one position per race!')
      end
    end

    context 'when trying to attribute the same position to two different racers' do
      it 'rolls back the conflicting operation and notify that a position cannot be occupied by more than one racer' do
        race = create(:race)
        racer1 = create(:racer)
        racer2 = create(:racer)
        Placement.create({ race_id: race.id, racer_id: racer1.id, position: 1 })
        result = Placement.create({ race_id: race.id, racer_id: racer2.id, position: 1 })
        expect(result.errors[:position].first).to eq('A position cannot be occupied for more than one racer!')
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:racer) }
    it { is_expected.to belong_to(:race)  }
  end
end
