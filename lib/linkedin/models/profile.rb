module LinkedIn
  module Models
    class Profile < Base
      def self.current
        find_by self: true
      end

      def self.find(id)
        find_by id: id
      end

      def self.find_by(selector)
        Profile.new client.profile(selector: selector)
      end
    end
  end
end
