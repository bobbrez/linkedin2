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
      all.detect { |indust| normalize_description(indust[:description]) == normalize_description(description) }
    end

    def self.find_group_names(*groups)
      Array[groups].flatten.map { |group| LinkedIn::API::Industries::GROUPS[group.to_sym] }
    end

    private

    def self.normalize_description(description)
      description.to_s.downcase.strip.gsub(' ','_').gsub(/[^\w]/, '').to_sym
    end
  end
end
