module LinkedIn
  module API
    module Companies
      def company(options={})
        selector = if options[:selector].respond_to? :each
          "::(#{options[:selector].join(',')})" 
        else
          "/#{options[:selector]}"
        end

        fields = options[:fields]
        fields_string = fields.blank? ? '' : ":(#{Permissions.render_permissions fields})"

        filter = "?#{options[:filter]}" if options[:filter].present?

        get "v1/companies#{selector}#{fields_string}#{filter}"
      end
    end
  end
end
