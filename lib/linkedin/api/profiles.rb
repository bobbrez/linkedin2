module LinkedIn
  module API
    module Profiles
      def profile(options={})
        get "v1/people/#{options}"
      end
    end
  end
end
