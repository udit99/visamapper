class Authorization
  include MongoMapper::Document
  belongs_to :user
  validates :provider, :uid, :presence => true  
end
