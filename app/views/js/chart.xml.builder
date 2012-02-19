xml.instruct! :xml, :version=>"1.0" 
xml.tag!("rows") do
    @pings.each do |events|
        xml.tag!("row",{ "id" => events.id }) do
            xml.tag!("cell", events.delay)
            xml.tag!("cell", "0")
        end
    end
end