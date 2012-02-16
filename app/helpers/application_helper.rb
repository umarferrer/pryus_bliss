module ApplicationHelper

	def titre
		titre_de_base="Bliss"
		if @titre.nil?
			titre_de_base
		else
			"#{titre_de_base} | #{@titre}"
		end
	end

	def logo
		image_tag("logo.png", :alt => "Bliss - Pryus")
	end
end
