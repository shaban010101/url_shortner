# frozen_string_literal: true

require 'securerandom'

class URLShortner
  def initialize
    @urls = {}
  end

  def generate(url)
    short_url = SecureRandom.hex(3)

    url = 'http://' + url unless url.start_with?('http://')

    urls[short_url.to_s] = url
    short_url
  end

  attr_reader :urls

  private

  attr_writer :urls
end
