class Departure < ActiveRecord::Base
  validates :trip_id, presence: true
  validates :status_id, presence: true
  validates :scheduledtime, presence: true
  has_one :status
  has_one :trip
end
