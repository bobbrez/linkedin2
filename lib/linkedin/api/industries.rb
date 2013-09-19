module LinkedIn
  module Industries
    def self.all
      INDUSTRIES
    end

    def self.[](code)
      find_by_code(code)
    end

    def self.find_by_code(code)
      INDUSTRIES.detect { |indust| indust[:code] == code }
    end

    def self.find_by_group(*groups)
      INDUSTRIES.reject { |indust| (groups & indust[:group]) != groups }
    end

    def self.find_by_description(description)
      INDUSTRIES.detect { |indust| indust[:description].to_s.downcase == description.to_s.downcase }
    end

    INDUSTRIES = [ { code: 1,   group: %i(gov tech),       description: 'Defense & Space' },
                   { code: 3,   group: %i(tech),           description: 'Computer Hardware' },
                   { code: 4,   group: %i(tech),           description: 'Computer Software' },
                   { code: 5,   group: %i(tech),           description: 'Computer Networking' },
                   { code: 6,   group: %i(tech),           description: 'Internet' },
                   { code: 7,   group: %i(tech),           description: 'Semiconductors' },
                   { code: 8,   group: %i(gov tech),       description: 'Telecommunications' },
                   { code: 9,   group: %i(leg),            description: 'Law Practice' },
                   { code: 10,  group: %i(leg),            description: 'Legal Services' },
                   { code: 11,  group: %i(corp),           description: 'Management Consulting' },
                   { code: 12,  group: %i(gov hlth tech),  description: 'Biotechnology' },
                   { code: 13,  group: %i(hlth),           description: 'Medical Practice' },
                   { code: 14,  group: %i(hlth),           description: 'Hospital & Health Care' },
                   { code: 15,  group: %i(hlth tech),      description: 'Pharmaceuticals' },
                   { code: 16,  group: %i(hlth),           description: 'Veterinary' },
                   { code: 17,  group: %i(hlth),           description: 'Medical Devices' },
                   { code: 18,  group: %i(good),           description: 'Cosmetics' },
                   { code: 19,  group: %i(good),           description: 'Apparel & Fashion' },
                   { code: 20,  group: %i(good rec),       description: 'Sporting Goods' },
                   { code: 21,  group: %i(good),           description: 'Tobacco' },
                   { code: 22,  group: %i(good),           description: 'Supermarkets' },
                   { code: 23,  group: %i(good man serv),  description: 'Food Production' },
                   { code: 24,  group: %i(good man),       description: 'Consumer Electronics' },
                   { code: 25,  group: %i(good man),       description: 'Consumer Goods' },
                   { code: 26,  group: %i(good man),       description: 'Furniture' },
                   { code: 27,  group: %i(good man),       description: 'Retail' },
                   { code: 28,  group: %i(med rec),        description: 'Entertainment' },
                   { code: 29,  group: %i(rec),            description: 'Gambling & Casinos' },
                   { code: 30,  group: %i(rec serv tran),  description: 'Leisure, Travel & Tourism' },
                   { code: 31,  group: %i(rec serv tran),  description: 'Hospitality' },
                   { code: 32,  group: %i(rec serv),       description: 'Restaurants' },
                   { code: 33,  group: %i(rec),            description: 'Sports' },
                   { code: 34,  group: %i(rec serv),       description: 'Food & Beverages' },
                   { code: 35,  group: %i(art med rec),    description: 'Motion Pictures and Film' },
                   { code: 36,  group: %i(med rec),        description: 'Broadcast Media' },
                   { code: 37,  group: %i(art med rec),    description: 'Museums and Institutions' },
                   { code: 38,  group: %i(art med rec),    description: 'Fine Art' },
                   { code: 39,  group: %i(art med rec),    description: 'Performing Arts' },
                   { code: 40,  group: %i(rec serv),       description: 'Recreational Facilities and Services' },
                   { code: 41,  group: %i(fin),            description: 'Banking' },
                   { code: 42,  group: %i(fin),            description: 'Insurance' },
                   { code: 43,  group: %i(fin),            description: 'Financial Services' },
                   { code: 44,  group: %i(cons fin good),  description: 'Real Estate' },
                   { code: 45,  group: %i(fin),            description: 'Investment Banking' },
                   { code: 46,  group: %i(fin),            description: 'Investment Management' },
                   { code: 47,  group: %i(corp fin),       description: 'Accounting' },
                   { code: 48,  group: %i(cons),           description: 'Construction' },
                   { code: 49,  group: %i(cons),           description: 'Building Materials' },
                   { code: 50,  group: %i(cons),           description: 'Architecture & Planning' },
                   { code: 51,  group: %i(cons gov),       description: 'Civil Engineering' },
                   { code: 52,  group: %i(gov man),        description: 'Aviation & Aerospace' },
                   { code: 53,  group: %i(man),            description: 'Automotive' },
                   { code: 54,  group: %i(man),            description: 'Chemicals' },
                   { code: 55,  group: %i(man),            description: 'Machinery' },
                   { code: 56,  group: %i(man),            description: 'Mining & Metals' },
                   { code: 57,  group: %i(man),            description: 'Oil & Energy' },
                   { code: 58,  group: %i(man),            description: 'Shipbuilding' },
                   { code: 59,  group: %i(man),            description: 'Utilities' },
                   { code: 60,  group: %i(man),            description: 'Textiles' },
                   { code: 61,  group: %i(man),            description: 'Paper & Forest Products' },
                   { code: 62,  group: %i(man),            description: 'Railroad Manufacture' },
                   { code: 63,  group: %i(agr),            description: 'Farming' },
                   { code: 64,  group: %i(agr),            description: 'Ranching' },
                   { code: 65,  group: %i(agr),            description: 'Dairy' },
                   { code: 66,  group: %i(agr),            description: 'Fishery' },
                   { code: 67,  group: %i(edu),            description: 'Primary/Secondary Education' },
                   { code: 68,  group: %i(edu),            description: 'Higher Education' },
                   { code: 69,  group: %i(edu),            description: 'Education Management' },
                   { code: 70,  group: %i(edu gov),        description: 'Research' },
                   { code: 71,  group: %i(gov),            description: 'Military' },
                   { code: 72,  group: %i(gov leg),        description: 'Legislative Office' },
                   { code: 73,  group: %i(gov leg),        description: 'Judiciary' },
                   { code: 74,  group: %i(gov),            description: 'International Affairs' },
                   { code: 75,  group: %i(gov),            description: 'Government Administration' },
                   { code: 76,  group: %i(gov),            description: 'Executive Office' },
                   { code: 77,  group: %i(gov leg),        description: 'Law Enforcement' },
                   { code: 78,  group: %i(gov),            description: 'Public Safety' },
                   { code: 79,  group: %i(gov),            description: 'Public Policy' },
                   { code: 80,  group: %i(corp med),       description: 'Marketing and Advertising' },
                   { code: 81,  group: %i(med rec),        description: 'Newspapers' },
                   { code: 82,  group: %i(med rec),        description: 'Publishing' },
                   { code: 83,  group: %i(med rec),        description: 'Printing' },
                   { code: 84,  group: %i(med serv),       description: 'Information Services' },
                   { code: 85,  group: %i(med rec serv),   description: 'Libraries' },
                   { code: 86,  group: %i(org serv),       description: 'Environmental Services' },
                   { code: 87,  group: %i(serv tran),      description: 'Package/Freight Delivery' },
                   { code: 88,  group: %i(org serv),       description: 'Individual & Family Services' },
                   { code: 89,  group: %i(org serv),       description: 'Religious Institutions' },
                   { code: 90,  group: %i(org serv),       description: 'Civic & Social Organization' },
                   { code: 91,  group: %i(org serv),       description: 'Consumer Services' },
                   { code: 92,  group: %i(tran),           description: 'Transportation/Trucking/Railroad' },
                   { code: 93,  group: %i(tran),           description: 'Warehousing' },
                   { code: 94,  group: %i(man tech tran),  description: 'Airlines/Aviation' },
                   { code: 95,  group: %i(tran),           description: 'Maritime' },
                   { code: 96,  group: %i(tech),           description: 'Information Technology and Services' },
                   { code: 97,  group: %i(corp),           description: 'Market Research' },
                   { code: 98,  group: %i(corp),           description: 'Public Relations and Communications' },
                   { code: 99,  group: %i(art med),        description: 'Design' },
                   { code: 100, group: %i(org),            description: 'Non-Profit Organization Management' },
                   { code: 101, group: %i(org),            description: 'Fund-Raising' },
                   { code: 102, group: %i(corp org),       description: 'Program Development' },
                   { code: 103, group: %i(art med rec),    description: 'Writing and Editing' },
                   { code: 104, group: %i(corp),           description: 'Staffing and Recruiting' },
                   { code: 105, group: %i(corp),           description: 'Professional Training & Coaching' },
                   { code: 106, group: %i(fin tech),       description: 'Venture Capital & Private Equity' },
                   { code: 107, group: %i(gov org),        description: 'Political Organization' },
                   { code: 108, group: %i(corp gov serv),  description: 'Translation and Localization' },
                   { code: 109, group: %i(med rec),        description: 'Computer Games' },
                   { code: 110, group: %i(corp rec serv),  description: 'Events Services' },
                   { code: 111, group: %i(art med rec),    description: 'Arts and Crafts' },
                   { code: 112, group: %i(good man),       description: 'Electrical/Electronic Manufacturing' },
                   { code: 113, group: %i(med),            description: 'Online Media' },
                   { code: 114, group: %i(gov man tech),   description: 'Nanotechnology' },
                   { code: 115, group: %i(art rec),        description: 'Music' },
                   { code: 116, group: %i(corp tran),      description: 'Logistics and Supply Chain' },
                   { code: 117, group: %i(man),            description: 'Plastics' },
                   { code: 118, group: %i(tech),           description: 'Computer & Network Security' },
                   { code: 119, group: %i(tech),           description: 'Wireless' },
                   { code: 120, group: %i(leg org),        description: 'Alternative Dispute Resolution' },
                   { code: 121, group: %i(corp org serv),  description: 'Security and Investigations' },
                   { code: 122, group: %i(corp serv),      description: 'Facilities Services' },
                   { code: 123, group: %i(corp),           description: 'Outsourcing/Offshoring' },
                   { code: 124, group: %i(hlth rec),       description: 'Health, Wellness and Fitness' },
                   { code: 125, group: %i(hlth),           description: 'Alternative Medicine' },
                   { code: 126, group: %i(med rec),        description: 'Media Production' },
                   { code: 127, group: %i(art med),        description: 'Animation' },
                   { code: 128, group: %i(cons corp fin),  description: 'Commercial Real Estate' },
                   { code: 129, group: %i(fin),            description: 'Capital Markets' },
                   { code: 130, group: %i(gov org),        description: 'Think Tanks' },
                   { code: 131, group: %i(org),            description: 'Philanthropy' },
                   { code: 132, group: %i(edu org),        description: 'E-Learning' },
                   { code: 133, group: %i(good),           description: 'Wholesale' },
                   { code: 134, group: %i(corp good tran), description: 'Import and Export' },
                   { code: 135, group: %i(cons gov man),   description: 'Mechanical or Industrial Engineering' },
                   { code: 136, group: %i(art med rec),    description: 'Photography' },
                   { code: 137, group: %i(corp),           description: 'Human Resources' },
                   { code: 138, group: %i(corp man),       description: 'Business Supplies and Equipment' },
                   { code: 139, group: %i(hlth),           description: 'Mental Health Care' },
                   { code: 140, group: %i(art med),        description: 'Graphic Design' },
                   { code: 141, group: %i(gov org tran),   description: 'International Trade and Development' },
                   { code: 142, group: %i(good man rec),   description: 'Wine and Spirits' },
                   { code: 143, group: %i(good),           description: 'Luxury Goods & Jewelry' },
                   { code: 144, group: %i(gov man org),    description: 'Renewables & Environment' },
                   { code: 145, group: %i(cons man),       description: 'Glass, Ceramics & Concrete' },
                   { code: 146, group: %i(good man),       description: 'Packaging and Containers' },
                   { code: 147, group: %i(cons man),       description: 'Industrial Automation' },
                   { code: 148, group: %i(gov),            description: 'Government Relations' } ]
  end
end
