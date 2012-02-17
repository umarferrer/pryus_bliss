class PingController < ApplicationController
	def ping
		@ping = Ping.all
	end
end
