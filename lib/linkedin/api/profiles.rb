module LinkedIn
  module API
    module Profiles
      def profile(options={})
        selector = options[:selector]
        selector_string = '~' if selector.blank?
        selector_string ||= selector.to_param

        fields = options[:fields]
        fields_string = fields.blank? ? '' : ":(#{Permissions.render_permissions fields})"

        get "v1/people/#{selector_string}#{fields_string}"
      end

      def connections(options={})
        selector = options[:selector].to_param || '~'
        selector_option = { selector: [ selector, 'connections' ].join('/') }

        profile options.slice(:selector).merge(selector_option)
      end
    end
  end
end
