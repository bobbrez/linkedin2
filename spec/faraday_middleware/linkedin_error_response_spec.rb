require 'spec_helper'

describe LinkedIn::FaradayMiddleware::LinkedinErrorResponse, vcr: { cassette_name: 'invalid' } do
  describe '#on_error' do
    it 'raises an error with the status and body reported by Rack included' do
      begin
        LinkedIn::Client.new.profile
      rescue LinkedIn::Error => error
        error.status.should eq 401
        error.body.should eq({
          'errorCode' => 0,
          'message' => 'Empty oauth2_access_token',
          'requestId' => 'TV9SBPHRO8',
          'status' => 401,
          'timestamp' => 1379777767455
        })
      end
    end

    it 'uses the message returned by LinkedIn' do
      begin
        LinkedIn::Client.new.profile
      rescue LinkedIn::Error => err
        err.message.should eq 'Empty oauth2_access_token'
      end
    end

    it 'includes the Faraday request/response object for further introspection by the consumer' do
      begin
        LinkedIn::Client.new.profile
      rescue LinkedIn::Error => err
        err.request.headers['User-Agent'].should eq 'Faraday v0.8.8'
        err.response.headers['Server'].should eq 'Apache-Coyote/1.1'
      end
    end

    it 'includes the LinkedIn error code' do
      pending 'These appear to be broken, so fuck \'em. http://developer.linkedin.com/forum/error-codes-are-not-set'
      begin
        LinkedIn::Client.new.profile
      rescue LinkedIn::Error => err
        pending 'we need to discuss camelCase vs snake_case. LinkedIn returns "errorCode"'
        err.error_code.should eq 
      end
    end
  end
end