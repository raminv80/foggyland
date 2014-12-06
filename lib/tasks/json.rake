namespace :json do
  task :generate, [:year] do |t, params|
    File.open("#{Rails.root}/db/#{params[:year]}.json", 'w') do |f|
      City.where(capital: true).each do |city|
        zip_code = city.zip_codes.first
        h = {
          zip_code.code => zip_code
                     .air_quality_indices
                     .where('extract(YEAR FROM observe_date) = ?', params[:year].to_i)
                     .order(:observe_date)
                     .map { |air| aqi(air.parameters) }
        }
        f.write(h.to_json)
      end
    end
  end

  def aqi(parameters, name = 'pm2.5')
    return -1 unless parameters

    return -1 unless parameters[name]

    return parameters[name]['aqi']
  end
end
