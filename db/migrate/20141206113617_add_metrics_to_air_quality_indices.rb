class AddMetricsToAirQualityIndices < ActiveRecord::Migration
  def change
    add_column :air_quality_indices, :ozone, :json
    add_column :air_quality_indices, :pm2_5, :json
    add_column :air_quality_indices, :pm10, :json
  end
end
