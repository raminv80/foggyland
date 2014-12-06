namespace :airnow do
  task :fetch, [:year] do |t, params|
    City.where(capital: true).each do |city|
      zip_code = city.zip_codes.first
      airnow = API::Airnow.new
      (1..12).each do |month|
        context = Contexts::AirQualityIndicesExtraction.new(API::Airnow.new, AirQualityIndex)
        context.execute(zip_code, DateTime.new(params[:year].to_i, month, 1))
      end
    end
  end
end
