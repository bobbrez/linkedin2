describe LinkedIn::API::Companies, vcr: { cassette_name: 'companies' }  do
  subject { LinkedIn::Client.new }

  describe '#company' do
    it 'fetches a company profile by id' do
      expect(subject.company(162479)['name']).to eq 'Apple'
    end

    it 'fetches a company profile by universal name' do
      expect(subject.company('universal-name=linkedin')['name']).to eq 'LinkedIn'
    end

    it 'fetches a company profile by e-mail domain' do
      companies = subject.company(filter: 'email-domain=apple.com')
      expect(companies['values'].first['name']).to eq 'Apple'
    end

    it 'fetches companies in bulk using their respective selectors' do
      companies = subject.company([162479, 'universal-name=linkedin'])
      expect(companies['values'].collect { |c| c['name'] }).to eq ['Apple', 'LinkedIn']
    end

    it 'fetches companies that the current user is an adminstrator of' do
      expect(subject.company(filter: 'is-company-admin=true')['_total']).to eq 0
    end
  end

  context 'todo' do
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
      pass
    end
  end
end
