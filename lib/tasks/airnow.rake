namespace :airnow do
  desc 'fetch by year'
  task :fetch, [:year] do |t, params|
    City.find_each do |city|
      context = Contexts::AirQualityIndicesExtraction.new(API::Airnow.new, AirQualityIndex)
      zip_code = city.zip_codes.first
      (1..12).each do |month|
        context.execute(zip_code, DateTime.new(params[:year].to_i, month, 1))
      end
    end
  end

  desc 'fetch AQI of one zip code for all cities'
  task :fetch_async, [:year] do |t, params|
    binding.pry
    City.includes(:zip_codes).find_each do |city|
      Workers::AirQualityIndicesExtraction.perform_year(city.zip_codes.first.id, params[:year].to_i)
    end
  end

  desc 'fetch by state and year'
  task :fetch_by_state_and_year, [:state_name, :year] do |t, params|
    state = State.where(name: params[:state_name]).first
    state.cities.each do |city|
      context = Contexts::AirQualityIndicesExtraction.new(API::Airnow.new, AirQualityIndex)
      zip_code = city.zip_codes.first
      airnow = API::Airnow.new
      (1..12).each do |month|
        context.execute(zip_code, DateTime.new(params[:year].to_i, month, 1))
      end
    end
  end
end
