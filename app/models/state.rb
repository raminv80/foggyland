class State < ActiveRecord::Base
  belongs_to :country
  has_many :cities

  validates :name, presence: true, uniqueness: true
end
