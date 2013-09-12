module Plagiarism
  class URLSearch < Search

    def initialize(search_url, options = {})
      validate_url(search_url)
      params = search_params(options).merge(q: search_url)
      @request = Request.new(:get, params)
      @response = @request.response
    end


  private


    def validate_url(url)
      uri = URI.parse URI.encode(url)
      raise "Please provide a valid search URL." unless uri.scheme && uri.host && uri.path
    end

  end
end