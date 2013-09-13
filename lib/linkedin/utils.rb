module LinkedIn
  module Utils
    def self.generate_random_state
      o = [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
      (0...50).map{ o[rand(o.length)] }.join
    end
  end
end
