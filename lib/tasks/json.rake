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
                     .map { |aqi| extract_metric(aqi.pm2_5) }
        }
        f.write(h.to_json)
      end
    end
  end

  def extract_metric(metric)
    return -1 if metric.blank?
    return metric['aqi']
  end
end
