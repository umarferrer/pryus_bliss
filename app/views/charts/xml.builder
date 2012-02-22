xml.instruct! :xml, :version=>"1.0" 
id=0
xml.tag!("data") do
    @charts.each do |events|
        xml.tag!("item",{ "id" => events.id }) do
            xml.tag!("delay", events.delay)
            xml.tag!("nb", id)
        end
		id=id+1
    end
end