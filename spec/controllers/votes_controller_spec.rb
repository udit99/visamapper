require 'spec_helper'

describe VotesController do
  let(:citizen_country_id_stub){ stub("citizen country id") }
  let(:stub_citizen_country){stub(id: citizen_country_id_stub)}
  let(:stub_visa_country_code){'us'}
  let(:stub_citizen_country_code){'in'}
  let(:stub_visa){{visa_id: stub_visa_id}}
  let(:stub_visa_id){5}
  let(:mock_vote){mock()}
  let(:user_vote){1}
  let(:stub_user_id){10}
  before do
    Country.stub(:find_by_country_code).with(stub_citizen_country_code).and_return(stub_citizen_country)
    Visa.stub(:find_by_country_id_and_country_code).with(citizen_country_id_stub, stub_visa_country_code).and_return(stub_visa)
    User.stub(:find).and_return(stub(id: stub_user_id))
  end
  describe "#create" do
    it "should create a vote from the params passed" do
      Vote.should_receive(:find_or_create_by_visa_id_and_user_id).with(stub_visa_id, 10).and_return(mock_vote)
      mock_vote.vote_value.should = user_vote
      mock_vote.should_receive(:save!)
      post 'create', {
        citizen_country: stub_citizen_country_code,
        visa_country_code: stub_visa_country_code,
        vote: user_vote
      }

    end
  end
end
