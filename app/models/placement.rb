class Placement < ApplicationRecord
  belongs_to :racer
  belongs_to :race

  validates :position, presence: true,
                       uniqueness: {  scope: :race_id,
                                      message: 'A position cannot be occupied for more than one racer!' }
  validates :racer_id, uniqueness: {  scope: :race_id,
                                      message: 'A racer can occupy only one position per race!' }
end
