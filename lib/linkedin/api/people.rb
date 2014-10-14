module LinkedIn
  module API
    module People
      def profile(selector = '~', **opts)
        execute 'people', { selector: selector }.merge(opts)
      end

      def connections(selector = '~', **opts)
        execute 'people', opts.merge(selector: selector, path: 'connections')
      end

      def people_search(query, **opts)
        wrapped_fields = opts[:fields].blank? ? nil : { people: opts[:fields] }
        execute 'people-search', opts.merge(params: query, fields: wrapped_fields)
      end
    end
  end
end
