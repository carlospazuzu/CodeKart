class CreatePlacements < ActiveRecord::Migration[7.0]
  def change
    create_table :placements do |t|
      t.integer :position
      t.belongs_to :racer
      t.belongs_to :race

      t.timestamps
    end
  end
end
