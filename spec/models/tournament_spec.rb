require 'rails_helper'

RSpec.describe Tournament, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:races) }
  end
end
