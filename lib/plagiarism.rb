module Plagiarism

  @test_mode = true
  @response_format = :xml


  class << self
    attr_accessor :username, :api_key, :test_mode, :response_format
  end


  # Return the current balance in your Copyscape account
  #
  def balance

  end


  # Return the number remaining credits in your Copyscape account
  #
  def credits

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
  def check_text(text, options = {})
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
  def check_url(url, options = {})
    URLSearch.new(url, options)
  end

end