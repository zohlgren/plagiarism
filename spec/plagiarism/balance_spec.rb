require 'spec_helper'

describe Plagiarism::Balance do

  before do
    Plagiarism.configure do |config|
      config.username = "COPYSCAPE_USERNAME"
      config.api_key = "COPYSCAPE_API_KEY"
    end
  end


  it "requires a Copyscape username" do
    Plagiarism.username = nil
    expect { Plagiarism::Balance.amount }.to raise_error
  end


  it "requires a Copyscape API key" do
    Plagiarism.api_key = nil
    expect { Plagiarism::Balance.amount }.to raise_error
  end


  it "returns the remaining account balance (in cents) for the account" do
    VCR.use_cassette "successful_balance_request" do
      Plagiarism::Balance.amount.should satisfy{|amount| amount >= 0}
    end
  end


  it "returns the remaining search credit for the account" do
    VCR.use_cassette "successful_balance_request" do
      Plagiarism::Balance.credits.should satisfy{|credits| credits >= 0}
    end
  end


end