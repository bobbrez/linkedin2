module LinkedIn
  module API
    module Profiles
      def profile(options={})
        selector = options[:selector]
        selector_string = '~' if selector.blank? || selector[:self]
        selector_string ||= selector.to_param

        fields = options[:fields]
        fields_string = fields.blank? ? '' : ":(#{Permissions.render_permissions fields})"

        get "v1/people/#{selector_string}#{fields_string}"
      end
    end
  end
end
