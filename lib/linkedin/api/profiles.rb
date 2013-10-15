module LinkedIn
  module API
    module Profiles
      # Finds a profile with the given options
      #
      # client.profile # => Finds the profile associated with the given access token's user. aka '~'
      #
      # client.profile 'id=some-id' # => Finds the profile using the given string as the selector
      #
      # client.profile id: 'some-id' # => Finds the profile using the passed key-value as the selector
      # 
      # @param options [nil, String, Hash]
      # @option options [Boolean] :public if true, will ignore fields and request the public profile
      # @option options [String, Array, Hash] :fields will be formatted into a LinkedIn fields string using Permissions#render_permissions.
      # @option options [String, Array] :path additional path options
      # @option options [*] * remaining options will be used as the selector, if no other fields are provided, '~' is assumed.
      def profile(options={})
        selector = '~'
        path = []
        pub = false
        fields = []

        if options.respond_to? :keys
          selectors = options.dup.slice!(:public, :fields, :path)
          raise ArgumentError.new("Received more than 1 selector: #{selectors}") if selectors.size > 1
          selector = selectors unless selectors.blank?
          path = Array[ * options[:path] ]
          pub = options[:public]
          fields = options[:fields] unless options[:fields].blank?
        else
          selector = options.to_s unless options.nil?
        end

        selector = ([ selector.to_param ] + path).join('/')

        fields_str = ':public' if pub
        fields_str ||= fields.blank? ? '' : ":(#{Permissions.render_permissions fields})"

        get "v1/people/#{selector}#{fields_str}"
      end

      # Essentally a convenience call to #profile that sets the :path option to :connections.
      def connections(options={})
        profile options.merge(path: :connections)
      end
    end
  end
end
