require 'spec_helper'

describe ApplicationHelper do
  describe "#current_user" do
    let(:stub_user){stub(:user)}
    let(:stub_user_id){stub(:userid)}
    it "should fetch the User by id fetched from params" do
      session[:user_id] = stub_user_id
      User.should_receive(:find).with(stub_user_id).and_return(stub_user)
      current_user.should == stub_user
    end 
  end
end
