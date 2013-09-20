require 'spec_helper'

describe LinkedIn::API::Jobs do
  describe '#jobs' do
    it "should be able to view a job listing" do
      pending "https://api.linkedin.com/v1/jobs/id=1586"
      subject.job(:id => 1586)
    end

    it "should be able to view its job bookmarks" do
      pending "https://api.linkedin.com/v1/people/~/job-bookmarks"
      subject.job_bookmarks
    end

    it "should be able to view its job suggestion" do
      pending "https://api.linkedin.com/v1/people/~/suggestions/job-suggestions"
      subject.job_suggestions
    end

    it "should be able to add a bookmark" do
      pending "https://api.linkedin.com/v1/people/~/job-bookmarks"
      response = subject.add_job_bookmark(:id => 1452577)
      response.body.should == nil
      response.code.should == "201"
    end

    it "should raise AccessDeniedError when LinkedIn returns 403 status code" do
      pending
    end
  end
end