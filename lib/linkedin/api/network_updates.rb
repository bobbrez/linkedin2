module LinkedIn
  module API
    module NetworkUpdates
      def network_updates(**options)
        get ['v1/people/~/network/updates', options[:selector], options[:attached_object_type]].compact.join '/'
      end

      def network_update_comments(**options)
        network_updates(options.merge attached_object_type: 'update-comments')
      end

      def network_update_likes(**options)
        network_updates(options.merge attached_object_type: 'likes')
      end
    end
  end
end
