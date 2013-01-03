require 'spec_helper'

describe HomeController do
  describe "#index" do
    let(:stub_countries){
      [america, japan, india]
    }
    let(:america){JSCountry.new(name: 'United_States_of_America', code: 'us')}
    let(:japan){JSCountry.new(name: 'Japan', code: 'jp')}
    let(:india){JSCountry.new(name: 'India', code: 'in')}
    let(:expected_output){
      {'in' => 'India',
       'jp' => 'Japan',
       'us' => 'United States of America'
      }
    }
    before do
      JSCountry.stub(:all).and_return(stub_countries)
    end
    it "should assign a hash of country codes and their corresponding display names" do
      get 'index'
      assigns[:country_mapping].should == expected_output
    end
  end
end
