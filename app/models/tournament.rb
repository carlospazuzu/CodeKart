class Tournament < ApplicationRecord
  validates :name, presence: true
  has_many :races, dependent: :destroy
end
