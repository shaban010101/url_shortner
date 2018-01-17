require 'sinatra'
require_relative 'lib/url_shortner'

class Application < Sinatra::Base
  url_shortner = URLShortner.new

  post '/api/url' do
    request_body = JSON.parse(request.body.read)
    url = request_body['url']
    halt 400, { error: 'Please provide a url' }.to_json if url.nil?

    generated_short_url = url_shortner.generate(url)
    short_url = "/#{generated_short_url}"

    status 201
    {
      short_url: short_url,
      url: url
    }.to_json
  end

  get /\/([a-zA-Z0-9]+)/ do |short_url|
    matched_url = url_shortner.urls[short_url]
    halt 404 unless matched_url
    redirect to(matched_url), 301
  end

  get '/api/urls' do
    url_shortner.urls.to_json
  end
end
