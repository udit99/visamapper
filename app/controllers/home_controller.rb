class HomeController < ApplicationController

  def index
    @country_mapping = JSCountry.all.sort.each_with_object({}) do|country,hash|
      hash[country.code] = country.display_name
    end
  end

end
