# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }
  let(:url) { 'http://www.farmdrop.com' }

  describe 'POST /api/url' do
    context 'when valid attributess are provided' do
      it 'responds successfully' do
        post('/api/url', JSON.generate(url: url))
        expect(last_response.status).to eq(201)
        expect(JSON.parse(last_response.body)).to include(
          'short_url' => be_a(String), 'url' => url
        )
      end
    end

    context 'when invalid attributes are provided' do
      it 'responds unsuccessfully' do
        [{ url: '' }, {}].each do |request_body|
          post('/api/url', JSON.generate(request_body))
          expect(last_response.status).to eq(400)
          expect(JSON.parse(last_response.body)).to eq(
            'error' => 'Please provide a url'
          )
        end
      end
    end
  end

  describe 'GET /' do
    context 'when the short url exists' do
      let(:shortend_url) do
        get('/api/urls')
        JSON.parse(last_response.body).keys.first
      end

      before do
        post '/api/url', JSON.generate({ url: url })
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

  describe 'GET /api/urls' do
    it 'responds successfully' do
      get('/api/urls')
      expect(JSON.parse(last_response.body)).to be_an(Hash)
    end
  end
end
