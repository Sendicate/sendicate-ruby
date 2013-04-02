require 'spec_helper'

describe Sendicate do

  describe "api_token" do
    
    it "should set token to env var" do
      Sendicate.api_token.should == ENV['SENDICATE_API_TOKEN']
    end
    
    it "should set token" do
      Sendicate.api_token = 'test'
      Sendicate.api_token.should == 'test'
    end
  end
end