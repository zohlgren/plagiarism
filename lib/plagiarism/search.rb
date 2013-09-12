module Plagiarism
  class Search

    attr_accessor :request, :response


    # Return the number of results found
    #
    def count
      @response.success? ? @response.doc.css("count").text.to_i : nil
    end


    # Return true if any results were found
    #
    def results?
      count && count > 0 ? true : false
    end

    # Return true if an error occurred
    #
    def error?
      @response && @response.error? ? true : false
    end


    # Return true if the search request was successful
    #
    def success?
      @response && @response.success? ? true : false
    end


    # Return the number of words checked
    #
    def words
      @response.success? ? @response.doc.css("querywords").text.to_i : nil
    end


    # Return the number of words matched from the source
    #
    def words_matched
      if @response.success?
        percentage = @response.doc.css("allwordsmatched").text
        percentage != "" ? percentage.to_i : nil
      else
        nil
      end
    end


    # Return the percentage of words matched from the source
    #
    def percentage_matched
      if @response.success?
        percentage = @response.doc.css("allpercentmatched").text
        percentage != "" ? percentage.to_i : nil
      else
        nil
      end
    end


    # Return the URL for viewing results
    #
    def results_url
      @response.doc.css("allviewurl").text if results?
    end


  protected


    def search_params(options)
      params = {
        o: operation_for_scope(options[:scope]),
        c: options[:full_comparisons] || 0
      }
      params.merge!(e: options[:encoding]) if options[:encoding] && self.class == TextSearch
      params
    end


    # Map search scope to an api operation
    #
    def operation_for_scope(scope)
      if scope && scope.to_sym == :full
        "cpsearch"
      elsif scope && scope.to_sym == :private
        "psearch"
      else
        "csearch"
      end
    end

  end
end