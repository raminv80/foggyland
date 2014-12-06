module Contexts
  class AirQualityIndicesExtraction
    def initialize(source, destination)
      @source = source
      @destination = destination
      assign_extractor(@destination)
    end

    def execute(zip_code, date)
      @destination.extract(@source, zip_code, date)
    end

    private

    def assign_extractor(destination)
      destination.extend(Extractor)
    end

    module Extractor
      def extract(source, zip_code, date)
        return if where(zip_code: zip_code, observe_date: date).exists?
        result = source.fetch(zip_code.code, date)
        return unless result
        create!(
          zip_code: zip_code, observe_date: result['date_observed'],
          latitude: result['latitude'], longitude: result['longitude'],
          ozone: result['ozone'].to_json,
          pm2_5: result['pm2.5'].to_json,
          pm10: result['pm10'].to_json
        )
      end
    end
  end
end
