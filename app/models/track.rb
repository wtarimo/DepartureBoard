class Track < ActiveRecord::Base
  belongs_to :station
  validates :number, presence: true
  validates :station_id, presence: true
end
