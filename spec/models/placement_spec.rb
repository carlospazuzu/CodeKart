require 'rails_helper'

RSpec.describe Placement, type: :model do
  describe 'Validations' do
    subject { build(:placement) }

    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_uniqueness_of(:position).scoped_to(:race_id)
      .with_message('A position cannot be occupied for more than one racer!') }
    it { is_expected.to validate_uniqueness_of(:racer_id).scoped_to(:race_id)
      .with_message('A racer can occupy only one position per race!') }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:racer) }
    it { is_expected.to belong_to(:race)  }
  end
end
