class Link
  include MongoMapper::Document

  belongs_to :visa
  key :url
  key :approved

  scope :approved, where(:approved => true) 
end
