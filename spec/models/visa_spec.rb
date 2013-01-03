require 'spec_helper'

describe Visa do
  let(:visa){Visa.new}
  let(:not_required_vote){stub(vote_value: VisaStatuses::VISA_NOT_REQUIRED)}
  let(:on_arrival_vote){stub(vote_value: VisaStatuses::VISA_AVAILABLE_ON_ARRIVAL)}
  let(:online_form_vote){stub(vote_value: VisaStatuses::ONLINE_FORM_REQUIRED_PRIOR_TO_ARRIVAL)}
  let(:visa_required_vote){stub(vote_value: VisaStatuses::VISA_REQUIRED_PRIOR_TO_ARRIVAL)}
  let(:travel_restricted_vote){stub(vote_value: VisaStatuses::TRAVEL_HIGHLY_RESTRICTED_OR_FORBIDDEN)}

  describe "#total_visa_not_required" do
    it "should return the correct count of visas not required" do
      visa.stub(:votes).and_return([not_required_vote, not_required_vote])
      visa.total_visa_not_required.should == 2
    end
  end

  describe "#total_visa_available_on_arrival" do
    it "should return the correct count of visas not required" do
      visa.stub(:votes).and_return([on_arrival_vote, on_arrival_vote])
      visa.total_visa_available_on_arrival.should == 2
    end
  end

  describe "#total_online_form_required_prior_to_arrival" do
    it "should return the correct count of visas not required" do
      visa.stub(:votes).and_return([online_form_vote, online_form_vote])
      visa.total_online_form_required_prior_to_arrival.should == 2
    end
  end

  describe "#total_visa_required" do
    it "should return the correct count of votes" do
      visa.stub(:votes).and_return([visa_required_vote, visa_required_vote])
      visa.total_visa_required.should == 2
    end
  end

  describe "#total_travel_restricted" do
    it "should return the correct count of votes" do
      visa.stub(:votes).and_return([travel_restricted_vote, travel_restricted_vote])
      visa.total_travel_restricted.should == 2
    end
  end
end
