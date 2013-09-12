require 'spec_helper'

describe Plagiarism::Request do

  before do
    Plagiarism.username = "USERNAME"
    Plagiarism.api_key = "API_KEY"
  end


  it "requires a Copyscape username to be configured" do
    Plagiarism.username = nil
    expect {
      Plagiarism::Request.new(:get)
    }.to raise_error(RuntimeError, "You must provide your Copyscape username")
  end


  it "requires a Copyscape API key to be configured" do
    Plagiarism.api_key = nil
    expect {
      Plagiarism::Request.new(:get)
    }.to raise_error(RuntimeError, "You must provide your Copyscape API key")
  end


  it "cannot be created without an HTTP request method" do
    expect {
      Plagiarism::Request.new
    }.to raise_error(ArgumentError)
  end


  it "cannot be created with an invalid request method" do
    expect {
      Plagiarism::Request.new(:foobar)
    }.to raise_error(RuntimeError, "Invalid or missing HTTP request method")
  end


  it "accepts a :get request method" do
    VCR.use_cassette "empty_get_request" do
      expect {
        Plagiarism::Request.new(:get)
      }.to_not raise_error
    end
  end


  it "accepts a :post request method" do
    VCR.use_cassette "empty_post_request" do
      expect {
        Plagiarism::Request.new(:post)
      }.to_not raise_error
    end
  end


  it "has a params hash after instantiation" do
    VCR.use_cassette "empty_get_request" do
      request = Plagiarism::Request.new(:get)
      request.params.should_not be_nil
    end
  end


  it "has a raw response object after instantiation" do
    VCR.use_cassette "empty_get_request" do
      request = Plagiarism::Request.new(:get)
      request.raw_response.should_not be_nil
    end
  end


  it "has a response object after instantiation" do
    VCR.use_cassette "empty_get_request" do
      request = Plagiarism::Request.new(:get)
      request.response.should_not be_nil
    end
  end


  it "includes the test parameter if test mode is enabled" do
    VCR.use_cassette "empty_get_request_in_test_mode" do
      Plagiarism.test_mode = true
      request = Plagiarism::Request.new(:get)
      Plagiarism.test_mode = false
      request.params.keys.index(:x).should_not be_nil
    end
  end


  it "excludes the test parameter if test mode is disabled" do
    VCR.use_cassette "empty_get_request" do
      request = Plagiarism::Request.new(:get)
      request.params.keys.index(:x).should be_nil
    end
  end

end