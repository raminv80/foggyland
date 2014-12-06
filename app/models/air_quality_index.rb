class AirQualityIndex < ActiveRecord::Base
  belongs_to :zip_code

  validates :zip_code_id, uniqueness: { scope: :observe_date }, presence: true
end
