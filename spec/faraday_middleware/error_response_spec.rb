describe LinkedIn::FaradayMiddleware::ErrorResponse, vcr: { cassette_name: 'invalid' } do
  subject { LinkedIn::Client.new(access_token: nil) }

  describe '#on_error' do
    it 'raises an error with the status and body reported by Rack included' do
      expect { subject.profile }.to raise_error do |error|
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
      expect { subject.profile }.to raise_error { |error| expect(error.message).to eq 'Empty oauth2_access_token' }
    end

    it 'includes the Faraday request/response object for further introspection by the consumer' do
      expect { subject.profile }.to raise_error do |error|
        error.request.headers['User-Agent'].should eq 'LinkedIn2 Gem v0.0.18'
        error.response.headers['server'].should eq 'Apache-Coyote/1.1'
      end
    end

    it 'includes the LinkedIn error code' do
      pending 'These appear to be broken, so fuck \'em. http://developer.linkedin.com/forum/error-codes-are-not-set'
      begin
        subject.profile
        raise 'Should have encountered an exception'
      rescue LinkedIn::Error => err
        pending 'we need to discuss camelCase vs snake_case. LinkedIn returns "errorCode"'
        err.error_code.should eq
      end
    end
  end
end
