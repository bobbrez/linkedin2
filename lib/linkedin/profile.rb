module LinkedIn
  class Profile < Base
    def self.current(*fields)
      find_by( { self: true }, *fields)
    end

    def self.find(id, *fields)
      find_by( { id: id }, *fields)
    end

    def self.find_by(selector, *fields)
      fields = fields.blank? ? API::Permissions.r_basicprofile : fields
      Profile.new client.profile( selector: selector, fields: fields )
    end
  end
end
