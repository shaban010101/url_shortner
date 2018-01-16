require 'spec_helper'

RSpec.describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }
  let(:url) { 'http://www.farmdrop.com' }
  
  describe 'POST /' do
    context 'when valid attributess are provided' do
      it 'responds successfully' do
        post('/', JSON.generate({ url: url }))
        expect(last_response.status).to eq(201)
        expect(JSON.parse(last_response.body)).to include(
          { 'short_url' => be_a(String), 'url' => url }
        )
      end
    end
    
    context 'when invalid attributes are provided' do
      it 'responds unsuccessfully' do
        post('/', '{}')
        expect(last_response.status).to eq(401)
        expect(JSON.parse(last_response.body)).to eq(
          { 'error' => 'Please provide a url' }
        )
      end
    end
  end

  describe 'GET /' do
    context 'when the short url exists' do
      let(:shortend_url) do
        get('/shortened_urls')
        JSON.parse(last_response.body).keys.first
      end

      before do
        post '/', JSON.generate({ url: url })
      end

      it 'redirects to the url' do
        get("#{shortend_url}")
        expect(last_response.status).to eq(301)
        expect(last_response.location).to eq(url)
      end
    end

    context 'when the short url does not exist' do
      it 'responds with a not found status' do
        get('/hhdhdh')
        expect(last_response.status).to eq(404)
      end
    end
  end

  describe 'GET /shortened_urls' do
    it 'responds successfully' do
      get('shortened_urls')
      expect(JSON.parse(last_response.body)).to be_an(Hash)
    end
  end
end
