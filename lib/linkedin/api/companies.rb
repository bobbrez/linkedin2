module LinkedIn
  module API
    module Companies
      def company(options={})
        selector = options[:selector].to_param

        fields = options[:fields]
        fields_string = fields.blank? ? '' : ":(#{Permissions.render_permissions fields})"

        get "v1/companies/#{selector}#{fields_string}"
      end
    end
  end
end
