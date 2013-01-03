module HomeHelper

  def options_for_countries
    countries = JSCountry.all.each.map{|c| [c.name.gsub(/_/," "), c.code]}
    countries.sort!{|kv1,kv2| kv1[0] <=> kv2[0] }
    options_for_select(countries)
  end

end
