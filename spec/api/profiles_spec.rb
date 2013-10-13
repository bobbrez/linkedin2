require 'spec_helper'

describe LinkedIn::API::Profiles, vcr: { cassette_name: 'profiles' } do
  subject { LinkedIn::Client.new }

  describe '#profile' do
    it 'should be able to fetch the profile of the current user' do
      profile = subject.profile

      profile['firstName'].should eq 'Josh'
      profile['lastName'].should eq 'Testjordan'
    end

    it "should be able to fetch publicly available profiles" do
      profile = subject.profile(selector: 'id=Fy5e5a4mqr')
      
      profile['firstName'].should eq 'Sir Richard'
      profile['lastName'].should eq 'B.'
    end

    it "should be able to fetch the connections of the current user" do
      subject.connections['values'].should have(2).things
    end

    it "should be able to view network_updates" do
      pending "https://api.linkedin.com/v1/people/~/network/updates"
      subject.network_updates
    end

    it "should be able to view network_update's comments" do
      pending "https://api.linkedin.com/v1/people/~/network/updates/key=network_update_key/update-comments"
      subject.share_comments("network_update_key")
    end

    it "should be able to view network_update's likes" do
      pending "https://api.linkedin.com/v1/people/~/network/updates/key=network_update_key/likes"
      subject.share_likes("network_update_key")
    end

    it "should be able to search with a keyword if given a String" do
      pending "https://api.linkedin.com/v1/people-search?keywords=business"
      subject.search("business")
    end

    it "should be able to search with an option" do
      pending "https://api.linkedin.com/v1/people-search?first-name=Javan"
      subject.search(:first_name => "Javan")
    end

    it "should be able to search with an option and fetch specific fields" do
      pending "https://api.linkedin.com/v1/people-search:(num-results,total)?first-name=Javan"
      subject.search(:first_name => "Javan", :fields => ["num_results", "total"])
    end

    it "should be able to share a new status" do
      pending "https://api.linkedin.com/v1/people/~/shares"
      response = subject.add_share(:comment => "Testing, 1, 2, 3")
      response.body.should == nil
      response.code.should == "201"
    end

    it "returns the shares for a person" do
      pending "https://api.linkedin.com/v1/people/~/network/updates?type=SHAR&scope=self&after=1234&count=35"
      subject.shares(:after => 1234, :count => 35)
    end

    it "should be able to comment on network update" do
      pending "https://api.linkedin.com/v1/people/~/network/updates/key=SOMEKEY/update-comments"
      response = subject.update_comment('SOMEKEY', "Testing, 1, 2, 3")
      response.body.should == nil
      response.code.should == "201"
    end

    it "should be able to send a message" do
      pending "https://api.linkedin.com/v1/people/~/mailbox"
      response = subject.send_message("subject", "body", ["recip1", "recip2"])
      response.body.should == nil
      response.code.should == "201"
    end

    it "should be able to like a network update" do
      pending "https://api.linkedin.com/v1/people/~/network/updates/key=SOMEKEY/is-liked"
      response = subject.like_share('SOMEKEY')
      response.body.should == nil
      response.code.should == "201"
    end

    it "should be able to unlike a network update" do
      pending "https://api.linkedin.com/v1/people/~/network/updates/key=SOMEKEY/is-liked"
      response = subject.unlike_share('SOMEKEY')
      response.body.should == nil
      response.code.should == "201"
    end

    it "should be able to pass down the additional arguments to OAuth's get_request_token" do
      pending 'this test is bullshit, reasses it in the context of this gem'
      consumer.should_receive(:get_request_token).with(
        {:oauth_callback => "http://localhost:3000/auth/callback"},  :scope => "rw_nus").and_return("request_token")

      request_token = subject.request_token(
        {:oauth_callback => "http://localhost:3000/auth/callback"},  :scope => "rw_nus"
      )

      request_token.should == "request_token"
    end

    it "should raise AccessDeniedError when LinkedIn returns 403 status code" do
      pending "https://api.linkedin.com/v1/people-search?first-name=Javan"
      expect{ subject.search(:first_name => "Javan") }.to raise_error(LinkedIn::Forbidden)
    end
  end
end