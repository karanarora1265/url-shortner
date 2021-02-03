class Link < ApplicationRecord

	has_many :link_stats

	validates :long_url, presence: true
	validates :long_url, format: URI::regexp(%w[http https])


	def self.get_by short_url
		id = UrlEncoder.new.decode_url(short_url)
		find_by id: id
	end

	def short_url
		UrlEncoder.new.encode_url(self.id, min_length=5)
	end

	def to_param
   		short_url
  	end

  	def top_countries
  		country_hash = {}
  		link_stats.each do |_link_stat|
  			country_hash[_link_stat.country] = country_hash[_link_stat.country].to_i + 1
  		end
  		country_hash.sort { |l, r| r[1]<=>l[1] }.collect{|country| country[0]}
  	end
end
