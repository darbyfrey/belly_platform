require 'spec_helper'
require 'belly_platform/boolean'

describe BellyPlatform::Boolean do
  context "#convert" do
    it "converts truthy values to true" do
      BellyPlatform::Boolean::TRUTHY_VALUES.each do |value|
        BellyPlatform::Boolean.convert(value).should be_true
      end
    end

    it "converts falsy values to false" do
      BellyPlatform::Boolean::FALSY_VALUES.each do |value|
        BellyPlatform::Boolean.convert(value).should be_false
      end
    end

    it "converts unexpected values to false" do
      BellyPlatform::Boolean.convert(['1','2','3']).should be_false
    end
  end

  context "#is_true?" do
    it "returns true for any truthy value" do
      BellyPlatform::Boolean::TRUTHY_VALUES.each do |value|
        BellyPlatform::Boolean.is_true?(value).should be_true
      end
    end

    it "returns false for any non-truthy value" do
      BellyPlatform::Boolean.is_true?('foo').should be_false
    end
  end

  context "#is_false?" do
    it "returns true for any falsy value" do
      BellyPlatform::Boolean::FALSY_VALUES.each do |value|
        BellyPlatform::Boolean.is_false?(value).should be_true
      end
    end

    it "returns false for any non-falsy value" do
      BellyPlatform::Boolean.is_false?('true').should be_false
    end
  end

  context "is_boolean?" do
    it "returns true for any truthy or falsy value" do
      (BellyPlatform::Boolean::TRUTHY_VALUES + BellyPlatform::Boolean::FALSY_VALUES).each do |value|
        BellyPlatform::Boolean.is_boolean?(value).should be_true
      end
    end

    it "returns false for an unrecognized value" do
      BellyPlatform::Boolean.is_boolean?('foo').should be_false
    end
  end
end