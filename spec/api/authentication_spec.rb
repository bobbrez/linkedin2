require 'spec_helper'

describe LinkedIn::API::Authentication, vcr: { cassette_name: 'authentication' } do
  describe 'authentication?' do
    client = LinkedIn::Client.new
    VCR.use_cassette 'authentication' do
      binding.pry
    end
  end
end