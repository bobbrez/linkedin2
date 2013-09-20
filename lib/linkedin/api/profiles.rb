module LinkedIn
  module API
    module Profiles
      def profile(options)
        selector = options.slice(:selector)[:selector]

        selector_string = '~' if selector.blank? || selector[:self]
        selector_string ||= selector.to_param

        get "v1/people/#{selector_string}"
      end
    end
  end
end
