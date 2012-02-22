class ChartsController < ApplicationController
	# def chart
        # @charts = Charts.where(:idmachine => params[:idmachine])
    # end
	def xml
        @charts = Charts.where(:idmachine => params[:idmachine])
    end
end
