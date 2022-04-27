class CreateShootLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :shoot_locations do |t|
      t.references :actor
      t.references :serie
      t.string :location
      t.timestamps
    end
  end
end
