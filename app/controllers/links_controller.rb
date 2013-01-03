class LinksController < ApplicationController
  def create
    citizenship_country_id = Country.find_by_country_code(params[:link_citizen_country]).id
    visa_country_code = params[:link_visa_country]
    visa = Visa.find_by_country_id_and_country_code(citizenship_country_id, visa_country_code)
    visa.links << Link.new(:url => params[:url], :approved => false)
    render :nothing => true
  end

  def index
    citizenship_country_id = Country.find_by_country_code(params[:citizen_country]).id
    visa_country_code = params[:visa_country]
    visa = Visa.find_by_country_id_and_country_code(citizenship_country_id, visa_country_code)
    @links = visa.links.approved
    render :layout => false
  end
end
