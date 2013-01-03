class Vote
  include MongoMapper::Document

  key :uid, String
  key :vote_value, Integer

  belongs_to :visa

  before_save   :clear_cache_fields_for_visa
  before_destroy :clear_cache_fields_for_visa

  def clear_cache_fields_for_visa
    visa.update_attributes({
      :visa_not_required_cache => nil,
      :visa_available_on_arrival_cache => nil,
      :online_form_required_cache => nil,
      :visa_required_cache => nil,
      :status_cache => nil,
      :travel_restricted_cache => nil
    }) if visa
  end
end
