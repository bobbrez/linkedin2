module LinkedIn
  module API
    module Messaging
      def send_message(subject, message, recipient_selectors)
        message_body = build_message_body selectors: [recipient_selectors].flatten,
                                          subject: subject, message: message

        execute 'people/~/mailbox', method: :post, body: message_body
      end

      private

      def build_message_body(**args)
        [:selectors, :subject, :message].each do |key|
          raise ArgumentError.new "Missing / blank argument `#{key}`" if args[key].blank?
        end

        recipients = args[:selectors].map { |sel| { person: { _path: "/people/#{sel.to_param}" } } }

        { recipients: { values: recipients }, subject: args[:subject], body: args[:message] }
      end
    end
  end
end
