require 'spec_helper'

describe Plagiarism::TextSearch do

  before do
    Plagiarism.configure do |config|
      config.username = "COPYSCAPE_USERNAME"
      config.api_key = "COPYSCAPE_API_KEY"
    end
    @search_text = "When in the Course of human events, it becomes necessary for one people to dissolve"
  end


  it "requires a Copyscape username" do
    Plagiarism.username = nil
    expect {
      Plagiarism::TextSearch.new("http://example.com")
    }.to raise_error
  end


  it "requires a Copyscape API key" do
    Plagiarism.api_key = nil
    expect {
      Plagiarism::TextSearch.new("http://example.com")
    }.to raise_error
  end


  it "must have a valid search query" do
    expect { Plagiarism::TextSearch.new }.to raise_error
  end


  it "will execute with a valid search query" do
    VCR.use_cassette "valid_text_search_with_results" do
      search = Plagiarism::TextSearch.new(@search_text)
      search.success?.should be_true
    end
  end


  context "when results are found" do
    it "will have a result count > 0" do
      VCR.use_cassette "valid_text_search_with_results" do
        search = Plagiarism::TextSearch.new(@search_text)
        search.count.should satisfy{|count| count > 0}
      end
    end
  end

end