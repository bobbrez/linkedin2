module LinkedIn
  class Profile < Base
    def connections
      @connections ||= client.connections(id: self.id)['values'].map { |c| Profile.new c }
    end

    def self.current(*fields)
      find_by fields: Array[*fields]
    end

    def self.find(id, *fields)
      find_by id: id, fields: Array[*fields]
    end

    def self.find_by(options)
      Profile.new client.profile( { fields: LinkedIn.r_basicprofile }.merge options)
    end
  end
end
