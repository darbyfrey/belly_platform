require 'spec_helper'
require 'belly_platform/string'
require 'belly_platform/boolean'

describe BellyPlatform::String do
  context "#check_type" do
    context "#integer" do
      it "returns true for a valid integer string" do
        BellyPlatform::String.validate('integer', '123').should be_true
        BellyPlatform::String.validate('integer', '-123').should be_true
        BellyPlatform::String.validate('integer', '1,234').should be_true
        BellyPlatform::String.validate('integer', '-1,234').should be_true
      end

      it "returns false for an invalid integer" do
        BellyPlatform::String.validate('integer', 'abc').should be_false
        BellyPlatform::String.validate('integer', ['1','2','3']).should be_false
      end
    end

    context "#boolean" do
      it "returns true for a valid boolean" do
        BellyPlatform::String.validate('boolean', 'true').should be_true
        BellyPlatform::String.validate('boolean', 'false').should be_true
      end

      it "returns false for an invalid boolean" do
        BellyPlatform::String.validate('boolean', 'abc').should be_false
        BellyPlatform::String.validate('boolean', ['1','2','3']).should be_false
      end
    end

    context "#timestamp" do
      it "returns true for a valid timestamp" do
        BellyPlatform::String.validate('timestamp', '1367520467').should be_true
        BellyPlatform::String.validate('timestamp', '2013-03-13 17:10:55').should be_true
      end

      it "returns false for an invalid timestamp" do
        BellyPlatform::String.validate('timestamp', 'invalid-time').should be_false
      end
    end

    context "#array_of_integers" do
      it "returns true for a valid array_of_integers" do
        BellyPlatform::String.validate('array_of_integers', '1,2,3').should be_true
      end

      it "returns true for an actual array" do
        BellyPlatform::String.validate('array_of_integers', ['1','2','3']).should be_true
      end

      it "returns false for an invalid array_of_integers" do
        BellyPlatform::String.validate('array_of_integers', '1,2,3,watermelon').should be_false
      end
    end

    context "#array_of_strings" do
      it "returns true for a valid array_of_strings" do
        BellyPlatform::String.validate('array_of_strings', '1234,hello,there').should be_true
      end

      it "returns true for an actual array" do
        BellyPlatform::String.validate('array_of_strings', ['1234','hello','there']).should be_true
      end

      it "returns false for an invalid array_of_strings" do
        BellyPlatform::String.validate('array_of_strings', 'a-complex string with invalid characters like & and +').should be_false
      end
    end
  end
end