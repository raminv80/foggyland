module API
  module V1
    class Root < Grape::API
      mount API::V1::AirQualityIndices
    end
  end
end
