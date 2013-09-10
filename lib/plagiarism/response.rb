require 'nokogiri'

module Plagiarism
  class Response

    attr_accessor :response, :doc


    def initialize(response)
      @response = response
      @doc = Nokogiri::XML(response.body) if @response.ok?
    end


    # Return true if the API call succeeded
    def success?
      @response.ok? && @doc.css("error").text == ""
    end


    # Return true if the API call did not succeed
    def error?
      not success?
    end


    # Return the body of the response
    def body
      @response ? @response.response.body : nil
    end


    # Return the HTTP status code from the response
    def status_code
      @response ? @response.response.code : nil
    end

  end
end