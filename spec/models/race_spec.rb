require 'rails_helper'

RSpec.describe Race, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:date)  }
    it { is_expected.to validate_presence_of(:place) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:placements) }
    it { is_expected.to have_many(:racers)     }
    it { is_expected.to belong_to(:tournament) }
  end
end
