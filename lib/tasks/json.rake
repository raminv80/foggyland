namespace :json do
  task :generate, [:year] => [:environment] do |t, params|
    CSV.open("#{Rails.root}/public/#{params[:year]}.csv", 'wb') do |csv|
      csv << ['zip_code'].concat(Date::MONTHNAMES.compact.map(&:downcase))
      City.includes(:zip_codes).find_each do |city|
        zip_code = city.zip_codes.first
        aqis = Hash[zip_code
                     .air_quality_indices
                     .where('extract(YEAR FROM observe_date) = ?', params[:year].to_i)
                     .order(:observe_date)
                     .map { |aqi| [aqi.observe_date.month, extract_metric(aqi.pm2_5)] }
                   ]
        next if aqis.values.empty?
        next if aqis.values.sum < 0
        result = [
          zip_code.code,
          aqis[1], aqis[2], aqis[3], aqis[4], aqis[5], aqis[6],
          aqis[7], aqis[8], aqis[9], aqis[10], aqis[11], aqis[12]
        ]
        csv << result
      end
    end
  end

  def extract_metric(metric)
    return -1 if metric.blank?
    return metric['aqi']
  end
end
