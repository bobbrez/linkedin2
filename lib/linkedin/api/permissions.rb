module LinkedIn
  module API
    module Permissions
      COMPANY = { 'company' => [ 'id', 'name', 'type', 'size', 'industry', 'ticker' ] }
      LOCATION = { 'location' => ['name', { 'country' => 'code' } ] }
      POSITIONS = { 'positions' => [ 'id', 'title', 'summary', 'start-date', 'end-date', 'is-current', COMPANY ] }
      PROFILE_REQ = { 'api-standard-profile-request' => ['url', 'headers'] }

      PROFILE_BASE = [ 'id', 'first-name', 'last-name','maiden-name', 'formatted-name', 'phonetic-first-name', 
                       'phonetic-last-name', 'formatted-phonetic-name', 'headline', 'industry', 'distance',
                       'current-share', 'num-connections', 'num-connections-capped', 'summary', 'specialties',
                       'picture-url', 'site-standard-profile-request', 'public-profile-url',
                       LOCATION, POSITIONS, PROFILE_REQ ]

      RELATION = { 'relation-to-viewer' => [ 'num-related-connections', 'related-connections' => PROFILE_BASE ] }

      MEMBER_RESOURCES = { 'member-url-resources' => [ 'url', 'name' ] }
      FULL_BASE = [ 'last-modified-timestamp', 'proposal-comments', 'associations', 'interests', 'publications',
                    'patents', 'languages', 'skills', 'certifications', 'educations', 'courses', 'volunteer',
                    'three-current-positions', 'three-past-positions', 'num-recommenders', 'recommendations-received',
                    'mfeed-rss-url', 'following', 'job-bookmarks', 'suggestions', 'date-of-birth',
                    'member-url-resources', 'related-profile-views', 'honors-awards' ]


      %i(company location positions profile_base relation member_resources full_base).each do |field|
        private_constant field.upcase
      end

      R_BASICPROFILE = PROFILE_BASE + [ RELATION ]
      R_EMAILADDRESS = [ 'email-address' ]
      R_FULLPROFILE = FULL_BASE + [ MEMBER_RESOURCES ]
      R_CONTACTINFO = [ 'phone-numbers', 'bound-account-types', 'im-accounts', 'main-address', 'twitter-accounts', 'primary-twitter-account']
      R_NETWORK = [ 'connections' ]
      RW_GROUPS = [ 'group-memberships' ]
      RW_NUS = [ 'network' ]
      W_MESSAGES = []

      def self.render_permissions (*fields)
        fields = fields.first if fields.size == 1

        return render_permissions(fields.map { |key, value| "#{key}:(#{render_permissions value})" }) if fields.respond_to? :keys
        return fields.map { |value| render_permissions value }.join ',' if fields.respond_to? :each
        fields.to_s
      end
    end
  end
end
