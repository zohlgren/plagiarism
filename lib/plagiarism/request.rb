require 'httparty'

module Plagiarism
  class Request
    include HTTParty

    base_uri "http://www.copyscape.com/api"

    attr_accessor :response, :raw_response, :params

    def initialize(method, options = {})
      @params = build_params(options)
      if method.eql? :get
        @raw_response = self.class.get('/', query: @params)
        @response = Response.new(@raw_response)
      elsif method.eql? :post
        @raw_response = self.class.post('/', body: @params)
        @response = Response.new(@raw_response)
      else
        raise "Invalid or missing HTTP request method"
      end
    end

  protected

    # Build the request parameters
    def build_params(options = {})
      raise "You must provide your Copyscape username" unless Plagiarism.username
      raise "You must provide your Copyscape API key" unless Plagiarism.api_key
      params = {
        u: Plagiarism.username,             # Copyscape username
        k: Plagiarism.api_key,              # Copyscape API key
        f: Plagiarism.response_format,      # Response format
      }.merge(options)
      params.merge!(x: 1) if Plagiarism.test_mode
      params
    end

  end
end