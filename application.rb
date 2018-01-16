require 'sinatra'
require_relative 'lib/url_shortner'

class Application < Sinatra::Base
  url_shortner = URLShortner.new

  post '/' do
    request_body = JSON.parse(request.body.read)
    url = request_body['url']
    halt 401, { error: 'Please provide a url' }.to_json if url.nil?

    generated_short_url = url_shortner.generate(url)
    short_url = "/#{generated_short_url}"

    status 201
    {
      short_url: short_url,
      url: url
    }.to_json
  end

  get '/shortened_urls' do
    url_shortner.urls.to_json
  end
end
