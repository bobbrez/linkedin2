describe LinkedIn::API::People, vcr: { cassette_name: 'people' } do
  subject { LinkedIn::Client.new }

  context '#profile' do
    it 'fetches the profile of the current user' do
      profile = subject.profile

      expect(profile['firstName']).to eq 'Josh'
      expect(profile['lastName']).to eq 'Testjordan'
    end

    it 'fetches publicly available profiles' do
      profile = subject.profile('id=Fy5e5a4mqr')

      expect(profile['firstName']).to eq 'Sir Richard'
      expect(profile['lastName']).to eq 'B.'
    end
  end

  context '#connections' do
    it 'fetches the connections of the current user' do
      expect(subject.connections['values']).to have(2).things
    end
  end

  context 'todo' do
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

  context '#connections' do
    it 'finds all connections for the current user' do
      linkedin_keys = %w(id headline firstName lastName industry location pictureUrl siteStandardProfileRequest)
      connections = subject.connections

      connections['values'].should_not be_nil
      connections['values'].first.keys.should include(*linkedin_keys)
    end

    it 'finds all connections for a user' do
      linkedin_keys = %w(id headline firstName lastName industry location pictureUrl siteStandardProfileRequest)
      connections = subject.connections

      connections['values'].should_not be_nil
      connections['values'].first.keys.should include(*linkedin_keys)
    end
  end
end
