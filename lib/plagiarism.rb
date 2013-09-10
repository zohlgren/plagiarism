require 'plagiarism/request'
require 'plagiarism/response'
require 'plagiarism/balance'
require 'plagiarism/search'
require 'plagiarism/url_search'
require 'plagiarism/text_search'

module Plagiarism

  @test_mode = false
  @response_format = :xml


  class << self

    attr_reader :response_format
    attr_accessor :username, :api_key, :test_mode

    def configure
      yield self
      self
    end


    # Return the current balance (in cents) in your Copyscape account
    #
    def balance
      Balance.amount
    end


    # Return the number remaining credits in your Copyscape account
    #
    def credits
      Balance.credits
    end


    # Search for copies of some text
    #
    # Options:
    #
    #   encoding:
    #     UTF-8, ISO-8859-1, etc. (default is UTF-8)
    #
    #   scope:
    #     public, private, full (default is public)
    #
    #   full_comparisons:
    #     number of full-text comparisons to request on matching
    #     results (default is 0, maximum is 10).
    #
    def text_search(text, options = {})
      TextSearch.new(text, options)
    end


    # Search for copies of a web page
    #
    # Options:
    #
    #   scope:
    #     public, private, full (default is public)
    #
    #   full_comparisons:
    #     number of full-text comparisons to request on matching
    #     results (default is 0, maximum is 10).
    #
    def url_search(url, options = {})
      URLSearch.new(url, options)
    end

  end

end