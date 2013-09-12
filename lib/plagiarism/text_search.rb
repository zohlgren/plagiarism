module Plagiarism
  class TextSearch < Search

    def initialize(search_text, options = {})
      validate_text(search_text)
      params = {e: "UTF-8", t: search_text}.merge!(search_params(options))
      @request = Request.new(:post, params)
      @response = @request.response
    end


  private


    def validate_text(text)
      raise "Invalid or missing search text." if text.class != String || text.nil? || text == ""
      raise "Search text must be at least 15 words." if text.split(" ").size < 15
    end

  end
end