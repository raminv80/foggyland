module Workers
  class AirQualityIndicesExtraction
    include Sidekiq::Worker

    def perform(zip_code_id, date)
      zip_code = ZipCode.find(zip_code_id)
      context = Contexts::AirQualityIndicesExtraction.new(API::Airnow.new, AirQualityIndex)
      context.execute(zip_code, date)
    end

    def self.perform_year(zip_code_id, year)
      (1..12).each do |month|
        perform_async(zip_code_id, DateTime.new(year, month, 1))
      end
    end
  end
end
