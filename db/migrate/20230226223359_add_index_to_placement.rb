class AddIndexToPlacement < ActiveRecord::Migration[7.0]
  def change
    add_index :placements, %i[position race_id racer_id], unique: true
  end
end
