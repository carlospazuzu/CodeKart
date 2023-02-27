class Racer < ApplicationRecord
  validates :name, :born_at, presence: true
  validates_with LegalAgeValidator

  has_many :placements, dependent: :destroy
  has_many :races, through: :placements, dependent: :destroy
end
