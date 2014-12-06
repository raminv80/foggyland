class Country < ActiveRecord::Base
  has_many :states

  validates :name, presence: true, uniqueness: true
end
