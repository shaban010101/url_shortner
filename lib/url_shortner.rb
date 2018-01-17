require 'securerandom'

class URLShortner
  def initialize
    @urls = {}
  end

  def generate(url)
    short_url = SecureRandom.hex(3)

    unless url.start_with?('http://')
      url = 'http://' + url
    end

    urls.merge!("#{short_url}" => url)
    short_url
  end
  
  attr_reader :urls

  private
  attr_writer :urls
end
