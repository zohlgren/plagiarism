require 'spec_helper'

describe Plagiarism::Response do

  before do
    Plagiarism.username = "USERNAME"
    Plagiarism.api_key = "API_KEY"
    VCR.use_cassette "empty_get_request" do
      @raw_response = Plagiarism::Request.new(:get).raw_response
    end
  end

  it "cannot be created without a response object" do
    expect {
      Plagiarism::Response.new
    }.to raise_error(ArgumentError)
  end


  it "has a response object after instantiation" do
    response = Plagiarism::Response.new(@raw_response)
    response.response.should_not be_nil
  end


  it "has a Nokogiri document object after instantiation" do
    response = Plagiarism::Response.new(@raw_response)
    response.doc.should_not be_nil
  end


end