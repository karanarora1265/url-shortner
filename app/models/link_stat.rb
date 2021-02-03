class LinkStat < ApplicationRecord
	EVENTS = {CLICKED: 'clicked'}
	belongs_to :link

	def self.capture(_link, request)
		create(link: _link, country: request.location.country, ip_address: request.ip, event: EVENTS[:CLICKED])
	end

end
