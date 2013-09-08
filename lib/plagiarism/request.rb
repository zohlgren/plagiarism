require 'net/http'

module Plagiarism
  class Request

    @base_uri = "http://www.copyscape.com/api"

  protected

    # Send the request
    def send(method, params)
      uri = URI(@base_uri)
      if method.eql? :get
        uri.query = URI.encode_www_form(params)
        Response.new Net::HTTP.get_response(uri)
      elsif method.eql? :post
        Response.new Net::HTTP.post_form(uri, params)
      else
        raise "Invalid HTTP request method"
      end
    end


    # Build the request parameters
    def request_params(options)
      raise "You must provide your Copyscape username" unless Plagiarism.username
      raise "You must provide your Copyscape API key" unless Plagiarism.api_key
      params = {
        u: Plagiarism.username,             # Copyscape username
        k: Plagiarism.api_key,              # Copyscape API key
        o: api_operation(options[:scope]),  # API operation
        c: options[:full_comparisons] || 0, # Full comparisons
        f: Plagiarism.response_format,      # Response format
      }
      params.merge!(x: 1) if Plagiarism.test_mode
      params.merge!(e: options[:encoding]) if self.class == TextSearch
      URI.encode_www_form params
    end


    # Map the search scope to an api operation
    def api_operation(scope)
      if scope == "full"
        "cpsearch"
      elsif scope == "private"
        "psearch"
      else
        "csearch"
      end
    end

  end
end