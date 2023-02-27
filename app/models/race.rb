class Race < ApplicationRecord
  validates :date, :place, presence: true

  has_many :placements, dependent: :destroy
  has_many :racers, through: :placements, dependent: :destroy

  accepts_nested_attributes_for :placements

  belongs_to :tournament

  def add_racer_placement(racer_id, position)
    Placement.create({position: position, racer_id: racer_id, race_id: self.id})
  end
end
