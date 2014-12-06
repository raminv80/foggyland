module API
  class Airnow
    include HTTParty
    base_uri 'www.airnowapi.org/aq/observation/zipCode/historical'
    default_params format: 'application/json'

    def fetch(zip_code, date)
      date_param = date.strftime('&Y-%m-%dT00-0000')
      options =
        {
          zip_code: zip_code,
          date: date_param,
          API_KEY: api_keys.sample
        }
      self.class.get('/', options)
    end

    def api_keys
      @api_keys ||= Figaro.env.air_api_keys.split(',')
    end
  end
end
