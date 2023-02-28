class Racer < ApplicationRecord
  validates :name, presence: true
  validates :born_at, presence: true,
                      comparison: { less_than_or_equal_to: 18.years.ago,
                                    message: 'Need to be at least 18 years old!' }

  has_many :placements, dependent: :destroy
  has_many :races, through: :placements, dependent: :destroy
end
