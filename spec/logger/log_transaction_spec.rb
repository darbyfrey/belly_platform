require 'spec_helper'
require 'belly_platform/logger/log_transaction'

describe BellyPlatform::LogTransaction do
  before(:each) do
    BellyPlatform::LogTransaction.clear
  end

  context "#id" do
    it "returns the current transaction id if it has been set" do
      id = SecureRandom.hex(10)
      Thread.current[:belly_tid] = id
      BellyPlatform::LogTransaction.id.should == id
    end

    it "sets and returns a new id if the transaction id hasn't been set" do
      BellyPlatform::LogTransaction.id.should_not be_nil
    end

    it "allows the id to be overridden by a setter" do
      BellyPlatform::LogTransaction.id.should_not be_nil
      BellyPlatform::LogTransaction.id = 'foo'
      BellyPlatform::LogTransaction.id.should == 'foo'
    end
  end

  context "#clear" do
    it "sets the id to nil" do
      BellyPlatform::LogTransaction.id.should_not be_nil
      BellyPlatform::LogTransaction.clear
      Thread.current[:belly_tid].should be_nil
    end
  end
end