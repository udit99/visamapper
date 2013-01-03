class JSCountry
  include MongoMapper::Document

  key :code, String
  key :name, String

  def display_name
    name.gsub(/_/," ")
  end


  def <=> (country)
    display_name <=> country.display_name
  end
end
