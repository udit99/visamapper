require 'spec_helper'

describe VisasController do

  describe "#index" do
    let(:citizen_country_id_stub){ stub("citizen country id") }
    let(:stub_citizen_country){stub(id: citizen_country_id_stub)}
    let(:stub_visa_country_code){'us'}
    let(:stub_citizen_country_code){'in'}
    let(:stub_visa){
      stub({
        total_visa_not_required: stub_visa_not_required,
        total_visa_available_on_arrival: stub_visa_available_on_arrival,
        total_online_form_required_prior_to_arrival: stub_online_form_on_arrival,
        total_visa_required: stub_visa_required,
        total_travel_restricted: stub_travel_restricted,
      })
    }
    let(:stub_visa_not_required){1}
    let(:stub_visa_available_on_arrival){2}
    let(:stub_online_form_on_arrival){3}
    let(:stub_visa_required){1}
    let(:stub_travel_restricted){0}
    let(:expected_output){
      {:visa_not_required => stub_visa_not_required,
       :visa_available_on_arrival => stub_visa_available_on_arrival,
       :online_form_required => stub_online_form_on_arrival,
       :visa_required => stub_visa_required,
       :travel_restricted => stub_travel_restricted
      }
    }
    before do
      Country.stub(:find_by_country_code).with(stub_citizen_country_code).and_return(stub_citizen_country)
      Visa.stub(:find_by_country_id_and_country_code).with(citizen_country_id_stub, stub_visa_country_code).and_return(stub_visa)
    end

    it "should render a JSON response of the visa stats for a given combination of citizenship country and visiting country" do
      get 'index', {visa_country_code: stub_visa_country_code,
                    citizen_country: stub_citizen_country_code}
      response.body.should == expected_output.to_json
    end
    
  end
  
end
