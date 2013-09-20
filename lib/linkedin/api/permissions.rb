require 'byebug'
module LinkedIn
  module API
    module Permissions
      BASIC_BASE = [ 'id', 'first-name', 'last-name','maiden-name', 'formatted-name', 'phonetic-first-name', 
                     'phonetic-last-name', 'formatted-phonetic-name', 'headline', 'industry', 'distance',
                     'current-share', 'num-connections', 'num-connections-capped', 'summary', 'specialties',
                     'positions', 'picture-url', 'site-standard-profile-request', 'public-profile-url',
                     { 'api-standard-profile-request' => ['url', 'headers'] } ]
      RELATION = { 'relation-to-viewer' => [ 'num-related-connections', 'related-connections' => BASIC_BASE ] }
      LOCATION = { 'location' => ['name', { 'country' => 'code' } ] }

      EMAIL_BASE = [ 'email-address' ]

      MEMBER_RESOURCES = { 'member-url-resources' => [ 'url', 'name' ] }
      FULL_BASE = [ 'last-modified-timestamp', 'proposal-comments', 'associations', 'interests', 'publications',
                    'patents', 'languages', 'skills', 'certifications', 'educations', 'courses', 'volunteer',
                    'three-current-positions', 'three-past-positions', 'num-recommenders', 'recommendations-received',
                    'mfeed-rss-url', 'following', 'job-bookmarks', 'suggestions', 'date-of-birth',
                    'member-url-resources', 'related-profile-views', 'honors-awards' ]

      CONTACT_BASE = [ 'phone-numbers', 'bound-account-types', 'im-accounts', 'main-address', 'twitter-accounts', 'primary-twitter-account']

      NETWORK_BASE = [ 'connections' ]

      GROUPS_BASE = [ 'group-memberships' ]

      NUS_BASE = [ 'network' ]

      def self.r_basicprofile
        @@r_basicprofile ||= BASIC_BASE + [ LOCATION ] + [ RELATION ]
      end

      def self.r_emailaddress
        @@r_emailaddress ||= EMAIL_BASE
      end

      def self.r_fullprofile
        @@r_fullprofile ||= FULL_BASE + [ MEMBER_RESOURCES ]
      end

      def self.r_contactinfo
        @@r_contactinfo ||= CONTACT_BASE
      end

      def self.r_network
        @@r_network ||= NETWORK_BASE
      end

      def self.rw_groups
        @@rw_groups ||= GROUPS_BASE
      end

      def self.rw_nus
        @@rw_nus ||= NUS_BASE
      end

      def self.render_permissions (*fields)
        fields = fields.first if fields.size == 1

        return render_permissions(fields.map { |key, value| "#{key}:(#{render_permissions value})" }) if fields.respond_to? :keys
        return fields.map { |value| render_permissions value }.join ',' if fields.respond_to? :each
        fields.to_s
      end
    end
  end
end
