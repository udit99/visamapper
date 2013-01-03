class CountriesController < ApplicationController

  def show
    visa_requirement_hash = {}
    country = Country.find_by_country_code(params[:id])
    country.visas.each{|v|
      visa_requirement_hash[v.country_code] = v.status
    }

    render :json => visa_requirement_hash
  end

end
