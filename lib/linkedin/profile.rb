module LinkedIn
  class Profile < Base
    def connections
      @connections ||= client.connections(selector: { id: self.id })['values'].map { |c| Profile.new c }
    end

    def self.current(*fields)
      find_by( { }, *fields)
    end

    def self.find(id, *fields)
      find_by( { id: id }, *fields)
    end

    def self.find_by(selector, *fields)
      fields = LinkedIn.r_basicprofile if fields.blank?
      Profile.new client.profile( selector: selector, fields: fields )
    end
  end
end
