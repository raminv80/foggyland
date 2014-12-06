class ZipCode < ActiveRecord::Base
  belongs_to :city
  has_many :air_quality_indices

  validates :code, presence: true, uniqueness: true
end
