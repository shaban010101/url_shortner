# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/url_shortner'

RSpec.describe URLShortner do
  let(:url) { 'http\:\/\/www.farmdrop.com' }

  describe '#generate' do
    it 'generates a short url from the inputted url' do
      expect(subject.generate(url)).to be_a(String)
    end
  end
end
