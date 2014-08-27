module LinkedIn
  module Fields
    COMPANY_CONTACT_INFO = { 'contact-info' => [ 'phone1', 'phone2', 'fax' ]}
    COMPANY_ADDRESS = { 'address' => [ 'street1', 'street2', 'city', 'state', 'postal-code', 'country-code', 'region-code' ]}
    COMPANY_LOCATIONS = { 'locations' => ['description', 'is-headquarters', 'is-active', COMPANY_ADDRESS, COMPANY_CONTACT_INFO ] }
    COMPANY = ['id', 'name', 'universal-name', 'email-domains', 'company-type', 'ticker', 'website-url',
               'industries', 'status', 'logo-url', 'square-logo-url', 'blog-rss-url', 'twitter-id',
               'employee-count-range', 'specialties', 'description', 'stock-exchange', 'founded-year', 'end-year', 'num-followers', COMPANY_LOCATIONS ]


    PROFILE_COMPANY = { 'company' => [ 'id', 'name', 'type', 'size', 'industry', 'ticker' ] }
    PROFILE_LOCATION = { 'location' => ['name', { 'country' => 'code' } ] }
    PROFILE_POSITIONS = { 'positions' => [ 'id', 'title', 'summary', 'start-date', 'end-date', 'is-current', COMPANY ] }
    PROFILE_API_STD_PROFILE_REQ = { 'api-standard-profile-request' => ['url', 'headers'] }

    BASE_BASIC_PROFILE = [ 'id', 'first-name', 'last-name','maiden-name', 'formatted-name', 'phonetic-first-name',
                           'phonetic-last-name', 'formatted-phonetic-name', 'headline', 'industry', 'distance',
                           'current-share', 'num-connections', 'num-connections-capped', 'summary', 'specialties',
                           'picture-url', 'site-standard-profile-request', 'public-profile-url',
                           PROFILE_LOCATION, PROFILE_POSITIONS, PROFILE_API_STD_PROFILE_REQ ]

    PROFILE_RELATION_TO_VIEWER = { 'relation-to-viewer' => [ 'num-related-connections', 'related-connections' => BASE_BASIC_PROFILE ] }

    PROFILE_MEMBER_URL_RESOURCES = { 'member-url-resources' => [ 'url', 'name' ] }
    BASE_FULL_PROFILE = [ 'last-modified-timestamp', 'proposal-comments', 'associations', 'interests', 'publications',
                          'patents', 'languages', 'skills', 'certifications', 'educations', 'courses', 'volunteer',
                          'three-current-positions', 'three-past-positions', 'num-recommenders', 'recommendations-received',
                          'mfeed-rss-url', 'following', 'job-bookmarks', 'suggestions', 'date-of-birth',
                          'related-profile-views', 'honors-awards' ]

    R_BASICPROFILE = BASE_BASIC_PROFILE + [ PROFILE_RELATION_TO_VIEWER ]
    R_EMAILADDRESS = [ 'email-address' ]
    R_FULLPROFILE = R_BASICPROFILE + BASE_FULL_PROFILE + [ PROFILE_MEMBER_URL_RESOURCES ]
    R_CONTACTINFO = [ 'phone-numbers', 'bound-account-types', 'im-accounts', 'main-address', 'twitter-accounts', 'primary-twitter-account']
    R_NETWORK = [ 'connections' ]
    RW_GROUPS = [ 'group-memberships' ]
    RW_NUS = [ 'network' ]
    W_MESSAGES = []

    def self.render(*fields)
      fields.compact!
      return '' if fields.blank?

      srender nil => fields
    end

    private

    def self.srender(*fields)
      fields = fields.first if fields.size == 1

      return srender(fields.map { |key, value| "#{key}:(#{srender value})" }) if fields.respond_to? :keys
      return fields.map { |value| srender value }.join ',' if fields.respond_to? :each

      fields.to_s
    end
  end
end
