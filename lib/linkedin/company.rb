module LinkedIn
  ADDRESS_FIELDS = [ 'street1', 'street2', 'city', 'state', 'postal-code', 'country-code', 'region-code' ]
  CONTACT_INFO_FIELDS = [ 'phone1', 'phone2', 'fax' ]
  COMPANY_LOCATIONS_FIELDS = ['description', 'is-headquarters', 'is-active', { 'address' => ADDRESS_FIELDS }, { 'contact-info' => CONTACT_INFO_FIELDS } ]
  COMPANY_BASE_FIELDS = [ 'id', 'name', 'universal-name', 'email-domains', 'company-type', 'ticker', 'website-url',
                         'industries', 'status', 'logo-url', 'square-logo-url', 'blog-rss-url', 'twitter-id', 'employee-count-range',
                         'specialties', { 'locations' => COMPANY_LOCATIONS_FIELDS }, 'description', 'stock-exchange', 'founded-year',
                         'end-year', 'num-followers' ]

  class Company < Base
    def self.find(id, *fields)
      find_by( { id: id }, *fields)
    end

    def self.find_by(selector, *fields)
      fields = fields.blank? ? COMPANY_BASE_FIELDS : fields
      Company.new client.company( selector: selector, fields: fields )
    end
  end
end
