module LinkedIn
  module API
    module Invitation
      def connect_with(recipient_selector, subject, message, type: :friend, x_auth_token: nil)
        if x_auth_token.blank?
          target_profile = profile recipient_selector, Fields::API_STD_PROFILE_REQ
          x_auth_token = target_profile.body.apiStandardProfileRequest_.headers_.values_.first.value
        end

        x_auth_name, x_auth_value = *x_auth_token.split(':')

        connection_body = build_connection_body selector: recipient_selector, subject: subject,
                                                message: message, type: type,
                                                auth_name: x_auth_name, auth_value: x_auth_value

        execute 'people/~/mailbox', method: :post, body: connection_body
      end

      private

      def build_connection_body(**args)
        [:selector, :subject, :message, :type, :auth_name, :auth_value].each do |key|
          raise ArgumentError.new "Missing / blank argument `#{key}`" if args[key].blank?
        end

        { recipients: { values: [ { person: { _path: "/people/#{args[:selector].to_param}" } } ] },
          subject: args[:subject],
          body: args[:message],
          'item-content' => {
            'invitation-request' => {
              'connect-type' => args[:type],
              authorization: { name: args[:auth_name], value: args[:auth_value] }
            }
          }
        }
      end
    end
  end
end
