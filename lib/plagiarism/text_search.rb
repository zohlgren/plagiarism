module Plagiarism
  class TextSearch < Search

    def initialize(search_text, options = {})
      validate_text(search_text)
      params = {e: "UTF-8", t: search_text}.merge(search_params(options))
      @request = Request.new(:post, params)
      @response = @request.response
    end


  private


    def validate_text(text)
      raise "Invalid search text" if text.class != String || text.nil? || text == ""
    end

  end
end