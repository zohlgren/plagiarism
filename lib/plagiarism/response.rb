require 'nokogiri'

module Plagiarism
  class Response

    attr_accessor :response, :doc


    def initialize(response)
      @response = response
      @doc = Nokogiri::XML(response.body) if @response.ok?
    end


    def success?
      @response.ok? && @doc.css("error").text == ""
    end


    def error?
      not success?
    end

  end
end