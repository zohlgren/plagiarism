require 'spec_helper'

describe Plagiarism::URLSearch do

  before do
    Plagiarism.username = "USERNAME"
    Plagiarism.api_key = "API_KEY"
    @search_url = "http://example.com"
  end


  it "cannot be created without a search url" do
    expect {
      Plagiarism::URLSearch.new
    }.to raise_error(ArgumentError)
  end


  it "cannot be created with an invalid search url" do
    expect {
      Plagiarism::URLSearch.new("example.com")
    }.to raise_error(RuntimeError, "Please provide a valid search URL.")
  end


  it "will execute with a valid search url" do
    VCR.use_cassette "valid_url_csearch_with_results" do
      search = Plagiarism::URLSearch.new(@search_url)
      search.success?.should be_true
    end
  end


  it "doesn't use full comparisons by default" do
    VCR.use_cassette "valid_url_csearch_with_results" do
      search = Plagiarism::URLSearch.new(@search_url)
      search.request.params[:c].should eq(0)
    end
  end


  it "allows a number of full comparisons to be specified" do
    VCR.use_cassette "valid_full_comparison_url_csearch_with_results" do
      search = Plagiarism::URLSearch.new(@search_url, full_comparisons: 3)
      search.request.params[:c].should eq(3)
    end
  end


  it "uses public search scope (csearch) by default" do
    VCR.use_cassette "valid_url_csearch_with_results" do
      search = Plagiarism::URLSearch.new(@search_url)
      search.request.params[:o].should eq("csearch")
    end
  end


  it "allows a private index search to be used" do
    VCR.use_cassette "valid_url_psearch_with_results" do
      search = Plagiarism::URLSearch.new(@search_url, scope: :private)
      search.request.params[:o].should eq("psearch")
    end
  end


  it "allows both public and private index search to be used" do
    VCR.use_cassette "valid_url_cpsearch_with_results" do
      search = Plagiarism::URLSearch.new(@search_url, scope: :full)
      search.request.params[:o].should eq("cpsearch")
    end
  end


end