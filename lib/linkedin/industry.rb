module LinkedIn
  module Industry
    def self.all
      LinkedIn::API::Industries::INDUSTRIES
    end

    def self.[](code)
      find_by_code(code)
    end

    def self.find_by_code(code)
      all.detect { |indust| indust[:code] == code }
    end

    def self.find_by_group(*groups)
      all.reject { |indust| (groups & indust[:group]) != groups }
    end

    def self.find_by_description(description)
      all.detect { |indust| indust[:description].to_s.downcase == description.to_s.downcase }
    end
  end
end
