require 'spec_helper'
require 'belly_platform/string'
require 'belly_platform/boolean'

describe BellyPlatform::String do
  context "#check_type" do
    context "nil value" do
      it "returns true when a value is nil" do
        BellyPlatform::String.validate('integer', nil).should be_true
      end
    end

    context "#integer" do
      it "returns true for a valid integer string" do
        BellyPlatform::String.validate('integer', '123').should be_true
        BellyPlatform::String.validate('integer', '-123').should be_true
        BellyPlatform::String.validate('integer', '1,234').should be_true
        BellyPlatform::String.validate('integer', '-1,234').should be_true
        BellyPlatform::String.validate('integer', 123).should be_true
      end

      it "returns false for an invalid integer" do
        BellyPlatform::String.validate('integer', 'abc').should be_false
        BellyPlatform::String.validate('integer', ['1','2','3']).should be_false
      end
    end

    context "#double" do
      it "returns true for a valid double" do
        BellyPlatform::String.validate('double', '123.4').should be_true
        BellyPlatform::String.validate('double', '123.45').should be_true
        BellyPlatform::String.validate('double', 123.4).should be_true
        BellyPlatform::String.validate('double', 123.45).should be_true
      end

      it "returns false for an invalid double" do
        BellyPlatform::String.validate('double', 'true').should be_false
        BellyPlatform::String.validate('double', [1,2,3]).should be_false
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

    context "#string" do
      it "returns true for any non nil string value" do
        BellyPlatform::String.validate('string', 'foo').should be_true
      end

      it "returns true for any nil string value" do
        BellyPlatform::String.validate('string', '').should be_true
      end
    end
  end

  context "#coerce" do
    context "empty value" do
      it "returns value if value empty" do
        BellyPlatform::String.coerce('integer', '').should == ''
        BellyPlatform::String.coerce('integer', nil).should == nil         
      end
    end

    context "#integer" do
      it "coerces a string correctly" do
        BellyPlatform::String.coerce('integer', '123').should == 123
        BellyPlatform::String.coerce('integer', 123).should == 123        
      end
    end

    context "#boolean" do
      it "coerces a boolean correctly" do
        BellyPlatform::String.coerce('boolean', 't').should == true
        BellyPlatform::String.coerce('boolean', 'true').should == true
        BellyPlatform::String.coerce('boolean', true).should == true 
        BellyPlatform::String.coerce('boolean', 'f').should == false
        BellyPlatform::String.coerce('boolean', 'false').should == false
        BellyPlatform::String.coerce('boolean', false).should == false        
      end
    end

    context "#double" do
      it "coerces a double correctly" do
        BellyPlatform::String.coerce('double', '123.45').should == 123.45
        BellyPlatform::String.coerce('double', 123.45).should == 123.45     
      end
    end

    context "#array_of_integers" do
      it "coerces a double correctly" do
        BellyPlatform::String.coerce('array_of_integers', '1,2,3').should == [1,2,3]
        BellyPlatform::String.coerce('array_of_integers', ['1','2','3']).should == [1,2,3]
      end
    end

    context "#array_of_strings" do
      it "coerces a double correctly" do
        BellyPlatform::String.coerce('array_of_strings', 'foo,bar,baz').should == ['foo','bar','baz']
        BellyPlatform::String.coerce('array_of_strings', ['foo','bar','baz']).should == ['foo','bar','baz']
      end
    end

    context "#timestamp" do
      it "coerces a timestamp correctly" do
        BellyPlatform::String.coerce('timestamp', '1376064517').should == "2013-08-09 11:08:37.000000000"
        BellyPlatform::String.coerce('timestamp', 1376064517).should == "2013-08-09 11:08:37.000000000"
        BellyPlatform::String.coerce('timestamp', '2013-08-09 11:08:37').should == "2013-08-09 11:08:37.000000000"
      end
    end
  end
end