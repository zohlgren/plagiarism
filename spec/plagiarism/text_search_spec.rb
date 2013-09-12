require 'spec_helper'

describe Plagiarism::TextSearch do

  before do
    Plagiarism.username = "USERNAME"
    Plagiarism.api_key = "API_KEY"
    @search_text = "When in the Course of human events, it becomes necessary for one people to dissolve"
  end


  it "cannot be created without a search query" do
    expect {
      Plagiarism::TextSearch.new
    }.to raise_error(ArgumentError)
  end


  it "cannot be created with an invalid search query" do
    expect {
      Plagiarism::TextSearch.new(12345)
    }.to raise_error(RuntimeError, "Invalid or missing search text.")
  end


  it "must have a search query of at least 15 words" do
    expect {
      invalid_query = "one two three four five six seven eight nine ten eleven twelve thirteen fourteen"
      Plagiarism::TextSearch.new(invalid_query)
    }.to raise_error(RuntimeError, "Search text must be at least 15 words.")
  end


  it "will execute with a valid search query" do
    VCR.use_cassette "valid_text_csearch_with_results" do
      search = Plagiarism::TextSearch.new(@search_text)
      search.success?.should be_true
    end
  end


  it "uses UTF-8 encoding by default" do
    VCR.use_cassette "valid_text_csearch_with_results" do
      search = Plagiarism::TextSearch.new(@search_text)
      search.request.params[:e].should eq("UTF-8")
    end
  end


  it "allows a different encoding to be specified" do
    VCR.use_cassette "valid_latin_encoded_text_csearch_with_results" do
      search = Plagiarism::TextSearch.new(@search_text, encoding: "ISO-8859-1")
      search.request.params[:e].should eq("ISO-8859-1")
    end
  end


  it "doesn't use full comparisons by default" do
    VCR.use_cassette "valid_text_csearch_with_results" do
      search = Plagiarism::TextSearch.new(@search_text)
      search.request.params[:c].should eq(0)
    end
  end


  it "allows a number of full comparisons to be specified" do
    VCR.use_cassette "valid_full_comparision_text_csearch_with_results" do
      search = Plagiarism::TextSearch.new(@search_text, full_comparisons: 3)
      search.request.params[:c].should eq(3)
    end
  end


  it "uses public search scope (csearch) by default" do
    VCR.use_cassette "valid_text_csearch_with_results" do
      search = Plagiarism::TextSearch.new(@search_text)
      search.request.params[:o].should eq("csearch")
    end
  end


  it "allows a private index search to be used" do
    VCR.use_cassette "valid_text_psearch_with_results" do
      search = Plagiarism::TextSearch.new(@search_text, scope: :private)
      search.request.params[:o].should eq("psearch")
    end
  end


  it "allows both public and private index search to be used" do
    VCR.use_cassette "valid_text_cpsearch_with_results" do
      search = Plagiarism::TextSearch.new(@search_text, scope: :full)
      search.request.params[:o].should eq("cpsearch")
    end
  end

end