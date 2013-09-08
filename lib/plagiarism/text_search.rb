module Plagiarism
  class TextSearch < Request

    def initialize(search_text, options = {})
      validate_text(search_text)
      options = {encoding: "UTF-8"}.merge(options)
      send(:post, request_params(options).merge(t: search_text)
    end

  private

    def validate_text(text)
      raise "Invalid search text" if text.class != String || text.nil? || text.eql? ""
    end

  end
end