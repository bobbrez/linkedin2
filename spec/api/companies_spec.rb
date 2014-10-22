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

  describe '#company_search' do
    it 'fetches company profiles by a search term', vcr: { cassette_name: 'company-search/by_single_keywords_option' } do
      expect(subject.company_search('apple')['companies']['values'].any? { |h| h.name.include? 'Apple' }).to be true
    end

    it 'fetches company profiles with fields included in the request', vcr: { cassette_name: 'company-search/by_keywords_options_with_fields' } do

      expect(subject.company_search('apple', fields: [{'companies' => ['id', 'name', 'industries', 'description', 'specialties']}, 'num-results'])['companies']['values'].any? { |h| h.name.include? 'Apple' }).to be true
    end

    it 'fetches company profiles with pagination', vcr: { cassette_name: 'company-search/by_single_keywords_option_with_pagination' } do

      companies = (subject.company_search('apple', filter: ["count=5", "start=5"])) 

      expect(companies['companies']['_count']).to eq 5
      expect(companies['companies']['_start']).to eq 5
    end

    it 'fetches company profiles and returns facets', vcr: { cassette_name: 'company-search/by_single_keywords_option_with_facets_to_return' } do

      companies = (subject.company_search('apple', facets: 'industry'))

      expect(companies['companies']['values'].any? { |h| h.name.include? 'Apple' }).to be true
      expect(companies['facets']['_total']).to eq 1
      expect(companies['facets']['buckets']['name']).to eq 'Industry'

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
