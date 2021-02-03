class LinksController < ApplicationController
	def new
		@link = Link.new
	end

	def create
		@link = Link.new(link_params)
		if @link.valid?
			@link.save
		end
	end

	def show
		@link = Link.get_by params[:short_url]
		if @link and @link.created_at > 1.month.ago
			LinkStat.capture(@link, request)
			redirect_to @link.long_url
		end
	end

	def stats
		@links = Link.includes(:link_stats).order(id: :desc)
	end

	private
	def link_params
		params.require(:link).permit(:long_url)
	end
end
