class User
  include MongoMapper::Document
  many :authorizations
  validates :name, :email, :presence => true


  key :provider, String
  key :uid, String
  key :user_id, Integer

end
