class Station < ActiveRecord::Base
	validates :name, presence: true
	has_many :tracks, dependent: :destroy
end
