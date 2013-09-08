module Plagiarism
  class URLSearch < Request

    def initialize(search_url, options = {})
      validate_url(search_url)
      send(:get, request_params(options).merge(q: search_url))
    end

  private

    def validate_url(url)
      uri = URI.parse URI.encode(url)
      raise "Please provide a valid search URL" unless uri.scheme && uri.host && uri.path
    end

  end
end