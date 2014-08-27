module LinkedIn
  module API
    module Companies
      def company(*selector, filter: filter, **opts)
        root = 'companies'

        selector.compact!
        selector = selector.first if selector.size == 1

        unless filter.blank?
          filter = Hash[ *filter.to_s.split('=') ] unless filter.respond_to? :keys
          opts[:params] = {} if opts[:params].blank?
          opts[:params].to_h.merge! filter
          selector = nil
        end

        if selector.respond_to? :each
          selector = "companies::(#{ selector.map(&:to_param).join(',') })"
          root = nil
        end

        execute root, opts.merge(selector: selector)
      end
    end
  end
end
