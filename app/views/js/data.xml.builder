xml.instruct! :xml, :version=>"1.0" 
xml.tag!("rows") do
  @administrateurs.each do |user|
        xml.tag!("row",{ "id" => user.id }) do
            xml.tag!("cell", user.nom_admin)
            xml.tag!("cell", user.prenom_admin)
            xml.tag!("cell", user.login_mail)
			xml.tag!("cell", "*********")
		end
    end
end