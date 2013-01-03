require 'spec_helper'

describe LinksController do
  let(:citizenship_country_id){ 2 }
  let(:stub_citizenship_country){stub(id: citizenship_country_id)}
  let(:visa_country_code){'us'}
  let(:citizenship_country_code){'in'}
  let(:stub_visa){stub("visa", links: [])}
  let(:stub_url){"www.foobar.com"}
  let(:stub_links){stub(:links)}

  before do
    Country.stub(:find_by_country_code).with(citizenship_country_id).and_return(stub_citizenship_country)
    Visa.stub(:find_by_country_id_and_country_code).with(citizenship_country_id, visa_country_code).and_return(stub_visa)
  end

  describe "#create" do
    def go
      post 'create', {link_citizen_country: citizenship_country_id, 
                      link_visa_country: visa_country_code,
                      url: stub_url}
    end

    it "should create a new link from the params passed in" do
      go
      stub_visa.links.size.should == 1
      link = stub_visa.links.first
      link.url.should == stub_url
      link.approved.should be_false
    end

    it "should fetch the Country and Visa information" do
      Country.should_receive(:find_by_country_code).with(citizenship_country_id).and_return(stub_citizenship_country)
      Visa.should_receive(:find_by_country_id_and_country_code).with(citizenship_country_id, visa_country_code).and_return(stub_visa)
      go
    end
  end

  describe "#index" do
    before do
      stub_visa.stub_chain(:links, :approved).and_return(stub_links)
    end

    def go
      get 'index', {visa_country: visa_country_code,
                    citizen_country: citizenship_country_id}
    end
    it "should assign the links for a given combination of citizen country and visa country" do
     go
     assigns[:links].should == stub_links
    end

    it "should fetch the Country and Visa information" do
      Country.should_receive(:find_by_country_code).with(citizenship_country_id).and_return(stub_citizenship_country)
      Visa.should_receive(:find_by_country_id_and_country_code).with(citizenship_country_id, visa_country_code).and_return(stub_visa)
      go
    end
  end

end
