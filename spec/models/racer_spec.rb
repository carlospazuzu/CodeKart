require 'rails_helper'

RSpec.describe Racer, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name)    }
    it { is_expected.to validate_presence_of(:born_at) }

    context 'when trying to register an underaged racer' do
      let(:underage_racer) { build(:racer, :underaged) }

      it 'marks the object as invalid' do
        expect(underage_racer.invalid?).to be true
      end

      it 'generates an error object in the errors array' do
        underage_racer.valid?
        expect(underage_racer.errors[:born_at].first).to eq('Need to be at least 18 years old!')
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:races) }
  end
end
