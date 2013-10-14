require 'spec_helper'

describe LinkedIn::API::Groups do
  describe '#jobs' do
  end

  context 'todo' do
    it "should be able to list group memberships for a profile" do
      pending "https://api.linkedin.com/v1/people/~/group-memberships"
      subject.group_memberships
    end

    it "should be able to join a group" do
      pending "https://api.linkedin.com/v1/people/~/group-memberships/123"

      response = subject.join_group(123)
      response.body.should == nil
      response.code.should == "201"
    end
    
    it "should raise AccessDeniedError when LinkedIn returns 403 status code" do
      pending
    end
  end
end