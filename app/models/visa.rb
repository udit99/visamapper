class Visa
  include MongoMapper::Document
  extend VisaStatuses

  key :name, String
  key :country_code, String
  key :status_cache, String
  belongs_to :country
  has_many :votes
  has_many :links

  def total_visa_not_required
    votes.select{|v| v.vote_value == VisaStatuses::VISA_NOT_REQUIRED}.count
  end

  def total_visa_available_on_arrival
     votes.select{|v| v.vote_value == VisaStatuses::VISA_AVAILABLE_ON_ARRIVAL}.count
  end

  def total_online_form_required_prior_to_arrival
    votes.select{|v| v.vote_value == VisaStatuses::ONLINE_FORM_REQUIRED_PRIOR_TO_ARRIVAL}.count
  end

  def total_visa_required
     votes.select{|v| v.vote_value == VisaStatuses::VISA_REQUIRED_PRIOR_TO_ARRIVAL}.count
  end

  def total_travel_restricted
     votes.select{|v| v.vote_value == VisaStatuses::TRAVEL_HIGHLY_RESTRICTED_OR_FORBIDDEN}.count
  end

  def status
      a = Visa.find(id)
    if a.status_cache.nil?
      a.status_cache = calculate_status
      a.save!
    end
      a.status_cache
  end

  private

  def calculate_status
    all_votes = [total_visa_not_required,
             total_visa_available_on_arrival,
             total_online_form_required_prior_to_arrival, 
             total_visa_required, 
             total_travel_restricted]
    max_votes = all_votes.max
    return VisaStatuses::DATA_UNCLEAR if max_votes == 0 || all_votes.count(max_votes) > 1
    return all_votes.find_index(max_votes)
  end
end
