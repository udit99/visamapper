require 'spec_helper'

describe CountriesController do
  let(:stub_country_code){'us'}
  let(:stub_country){stub(visas: stub_visa_list)}
  let(:stub_visa_list){[visa_status1, visa_status2]}
  let(:visa_status1){stub(country_code: 'in', status: 0)}
  let(:visa_status2){stub(country_code: 'jp', status: 1)}
  let(:expected_output){
    {'in'=> 0,
     'jp'=> 1
    }
  }

  before do
    Country.stub(:find_by_country_code).with(stub_country_code).and_return(stub_country)
  end

  describe "#show" do
    it "should fetch the country by country code" do
      Country.should_receive(:find_by_country_code).with(stub_country_code).and_return(stub_country)
      get 'show', {id: stub_country_code}
    end

    it "should render the visa requirement hash" do
      get 'show', {id: stub_country_code}
      response.body.should == expected_output.to_json
    end
  end
end
