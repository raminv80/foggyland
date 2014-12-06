class AddParametersToAirQualityIndices < ActiveRecord::Migration
  def change
    add_column :air_quality_indices, :parameters, :hstore
  end
end
