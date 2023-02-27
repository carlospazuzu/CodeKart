class CreateRaces < ActiveRecord::Migration[7.0]
  def change
    create_table :races do |t|
      t.date :date
      t.string :place
      t.belongs_to :tournament

      t.timestamps
    end
  end
end
