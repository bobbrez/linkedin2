require 'spec_helper'

describe LinkedIn::API::Profiles, vcr: { cassette_name: 'network_updates' } do
  subject { LinkedIn::Client.new }

  describe '#network_updates' do
    it 'fetches network updates for the current user' do
      network_updates = subject.network_updates
      network_updates['_total'].should eq 13
      network_updates['values'].should have(10).things
    end

    it 'fetches network updates by key' do
      network_updates = subject.network_updates(selector: 'key=PROF-18939563-5794095336964247552-*1')
      network_updates['updatedFields']['values'].should have(1).thing
    end
  end

  describe '#network_update_comments' do
    it 'fetches comments for network updates' do
      comments = subject.network_update_comments(selector: 'key=PROF-18939563-5794095336964247552-*1')
      comments['values'].first['comment'].should eq 'Whaaaat'
    end
  end

  describe '#network_update_likes' do
    it 'fetches "likes" for network updates' do
      likes = subject.network_update_likes(selector: 'key=PROF-18939563-5794095336964247552-*1')
      likes['values'].first['person']['id'].should eq 'cDmdM9cb0H'
    end
  end
end