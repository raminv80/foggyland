module API
  module V1
    class AirQualityIndices < Grape::API
      include API::V1::Defaults

      resource :air_quality_indices do
        desc 'Return a list of air quality indices by year.'
        params do
          requires :year, type: Integer, desc: 'Year'
        end
        route_param :year do
          get do
            AirQualityIndex.where('extract(YEAR FROM observe_date) = ?', params[:year])
          end
        end
      end
    end
  end
end
