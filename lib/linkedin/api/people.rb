module LinkedIn
  module API
    module People
      def profile(options={})
        get "v1/people/#{options}"
      end
    end
  end
end
