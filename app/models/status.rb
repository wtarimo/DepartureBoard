class Status < ActiveRecord::Base
	validates :given, presence: true
end
