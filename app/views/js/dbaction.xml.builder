xml.instruct! :xml, :version=>"1.0"

xml.tag!("data") do
    xml.tag!("action",{ "type" => @mode, "sid" => @id, "tid" => @tid })
end