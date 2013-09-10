require 'spec_helper'

describe Plagiarism::URLSearch do

  before do
    Plagiarism.configure do |config|
      config.username = "COPYSCAPE_USERNAME"
      config.api_key = "COPYSCAPE_API_KEY"
    end
    @search_url = "http://example.com"
  end


  it "requires a Copyscape username" do
    Plagiarism.username = nil
    expect {
      Plagiarism::TextSearch.new(@search_url)
    }.to raise_error
  end


  it "requires a Copyscape API key" do
    Plagiarism.api_key = nil
    expect {
      Plagiarism::URLSearch.new(@search_url)
    }.to raise_error
  end


  it "must have a valid search url" do
    expect {
      Plagiarism::URLSearch.new("example.com")
    }.to raise_error
  end


  it "will execute with a valid search url" do
    VCR.use_cassette "valid_url_search_with_results" do
      search = Plagiarism::URLSearch.new("http://example.com")
      search.success?.should be_true
    end
  end


  context "when results are found" do
    it "will have a result count > 0" do
      VCR.use_cassette "valid_url_search_with_results" do
        search = Plagiarism::URLSearch.new("http://example.com")
        search.count.should satisfy{|count| count > 0}
      end
    end
  end

end