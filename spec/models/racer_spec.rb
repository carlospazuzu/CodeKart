require 'rails_helper'

RSpec.describe Racer, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name)    }
    it { is_expected.to validate_presence_of(:born_at) }

    context 'when racer is underaged (18 years old)' do
      let(:underage_racer) { build(:racer, :underaged) }

      it 'returns an invalid racer' do
        expect(underage_racer.invalid?).to be true
      end

      it 'returns an error' do
        underage_racer.valid?
        expect(underage_racer.errors[:born_at].first).to eq('Need to be at least 18 years old!')
      end
    end

    context 'when racer have a legal age' do
      let(:legal_racer) { build(:racer) }

      it 'returns a valid racer' do
        expect(legal_racer.valid?).to be true
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:races)      }
    it { is_expected.to have_many(:placements) }
  end
end
