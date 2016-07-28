class Trip < ActiveRecord::Base
	validates :number, presence: true
	validates :origin_id, presence: true
	validates :destination_id, presence: true
end
