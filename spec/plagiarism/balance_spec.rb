require 'spec_helper'

describe Plagiarism::Balance do

  before do
    Plagiarism.username = "USERNAME"
    Plagiarism.api_key = "API_KEY"
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