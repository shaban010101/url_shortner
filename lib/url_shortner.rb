require 'securerandom'

class URLShortner
  def initialize
    @urls = {}
  end

  def generate(url)
    short_url = SecureRandom.hex(3)
    urls.merge!("#{short_url}" => url)
    short_url
  end
  
  attr_reader :urls

  private
  attr_writer :urls
end
