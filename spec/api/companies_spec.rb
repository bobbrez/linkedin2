require 'spec_helper'

describe LinkedIn::API::Companies do
  subject { LinkedIn::Client }

  describe '#company' do
    it "should be able to view a company profile" do
      pending "https://api.linkedin.com/v1/companies/id=1586"
      subject.company(:id => 1586)
    end

    it "should be able to view a company by universal name" do
      pending "https://api.linkedin.com/v1/companies/universal-name=acme"
      subject.company(:name => 'acme')
    end

    it "should be able to view a company by e-mail domain" do
      pending "https://api.linkedin.com/v1/companies?email-domain=acme.com"
      subject.company(:domain => 'acme.com')
    end

    it "should load correct company data" do
      pending
      data = subject.company(:id => 1586, :fields => %w{ id name industry locations:(address:(city state country-code) is-headquarters) employee-count-range })
      data.id.should == 1586
      data.name.should == "Amazon"
      data.employee_count_range.name.should == "10001+"
      data.industry.should == "Internet"
      data.locations.all[0].address.city.should == "Seattle"
      data.locations.all[0].is_headquarters.should == true
    end

    it "should raise AccessDeniedError when LinkedIn returns 403 status code" do
      pending
    end
  end
end