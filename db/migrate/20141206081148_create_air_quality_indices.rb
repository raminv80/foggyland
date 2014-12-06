class CreateAirQualityIndices < ActiveRecord::Migration
  def change
    create_table :air_quality_indices do |t|
      t.date :observe_date
      t.integer :value
      t.references :zip_code, index: true
      t.integer :rating_number
      t.string :rating_name
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
    add_index :air_quality_indices, :observe_date
  end
end
