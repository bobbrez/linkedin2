describe LinkedIn::API::NetworkUpdates, vcr: { cassette_name: 'network_updates' } do
  subject { LinkedIn::Client.new }

  context '#network_updates' do
    it 'fetches network updates for the current user' do
      network_updates = subject.network_updates
      expect(network_updates['_total']).to eq 13
      expect(network_updates['values']).to have(10).things
    end

    it 'fetches network updates by key' do
      network_updates = subject.network_updates(key: 'PROF-18939563-5794095336964247552-*1')
      network_updates['updatedFields']['values'].should have(1).thing
    end

    it 'fetches comments for network updates' do
      comments = subject.network_updates(key: 'PROF-18939563-5794095336964247552-*1', type: 'update-comments')
      comments['values'].first['comment'].should eq 'Whaaaat'
    end
    
    it 'fetches "likes" for network updates' do
      likes = subject.network_updates(key: 'PROF-18939563-5794095336964247552-*1', type: 'likes')
      likes['values'].first['person']['id'].should eq 'cDmdM9cb0H'
    end
  end
end
