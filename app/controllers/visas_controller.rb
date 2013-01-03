class VisasController < ApplicationController

  def index
    citizenship_country_id = Country.find_by_country_code(params[:citizen_country]).id
    visa_country_code = params[:visa_country_code]
    visa = Visa.find_by_country_id_and_country_code(citizenship_country_id, visa_country_code)
    visa_values = {
      :visa_not_required => visa.total_visa_not_required,
      :visa_available_on_arrival => visa.total_visa_available_on_arrival,
      :online_form_required => visa.total_online_form_required_prior_to_arrival,
      :visa_required => visa.total_visa_required,
      :travel_restricted => visa.total_travel_restricted}

    render :json => visa_values
  end
end
