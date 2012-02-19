class ChartsController < ApplicationController
	def chart
        @charts = Charts.all()
    end
end
