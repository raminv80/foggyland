module API
  class Airnow
    include HTTParty
    base_uri 'www.airnowapi.org/aq/observation/zipCode/historical'
    default_params format: 'application/json'

    def initialize
      self.class.default_params API_KEY: api_keys.sample
    end

    def fetch(zip_code, date)
      date_param = date.strftime('%Y-%m-%dT00-0000')
      options =
        {
          'zipCode' => zip_code,
          'date' => date_param
        }
      responses = self.class.get('/', query: options)
      return false if responses.empty?
      results = Hash[responses.map { |r| [r['ParameterName'], r] }]
      response = responses.first
      {
        'date_observed' => response['DateObserved'].to_datetime,
        'latitude' => response['Latitude'],
        'longitude' => response['Longitude'],
        'ozone' => format_parameter(results['OZONE']),
        'pm2.5' => format_parameter(results['PM2.5']),
        'pm10' => format_parameter(results['PM10'])
      }
    end

    def format_parameter(parameter)
      return nil unless parameter
      {
        'aqi' => parameter['AQI'],
        'category' => {
          'number' => parameter['Category']['Number'],
          'name' => parameter['Category']['Name']
        }
      }
    end

    def api_keys
      @api_keys ||= Figaro.env.air_api_keys.split(',')
    end
  end
end
