class State < ActiveRecord::Base
  belongs_to :country
  has_many :cities

  validates :code, presence: true, uniqueness: true
end
