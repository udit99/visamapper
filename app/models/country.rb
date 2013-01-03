class Country
  include MongoMapper::Document

  key :name, String
  key :country_code, String
  many :visas
end
