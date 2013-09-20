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

      def self.r_basicprofile
        BASIC_BASE + [ LOCATION ] + [ RELATION ]
      end

      def self.render_permission_fields(*fields)
        fields = fields.first if fields.size == 1

        return render_permission_fields(fields.map { |key, value| render_nested_permission_fields key, value  }) if fields.respond_to? :keys
        return fields.map { |value| render_permission_fields value }.join ',' if fields.respond_to? :each
        fields.to_s
      end

      def self.render_nested_permission_fields(key, value)
        "#{key}:(#{render_permission_fields(value)})"
      end
    end
  end
end
