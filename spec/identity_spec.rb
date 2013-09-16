require 'spec_helper'
require 'belly_platform/identity'

describe BellyPlatform::Identity do
  context "#name" do
    it "returns 'api-service' if no ENV['SERVICE_NAME'] is set" do
      ENV['SERVICE_NAME'] = nil
      BellyPlatform::Identity.name.should == 'api-service'
    end

    it "returns the ENV['SERVICE_NAME'] when specified" do
      ENV['SERVICE_NAME'] = nil
      ENV['SERVICE_NAME'] = 'my-service'
      BellyPlatform::Identity.name.should == 'my-service'
    end
  end

  context "#hostname" do
    it "returns the value of the hostname system call and doesn't make a second system call" do
      BellyPlatform::Identity.should_receive(:`).with("hostname").and_return("system-hostname")
      BellyPlatform::Identity.hostname.should == 'system-hostname'

      BellyPlatform::Identity.should_not_receive(:`).with("hostname")
      BellyPlatform::Identity.hostname.should == 'system-hostname'
    end
  end

  context "#revision" do
    it "returns the value of the 'git rev-parse HEAD' system call and doesn't make a second system call" do
      BellyPlatform::Identity.should_receive(:`).with("git rev-parse HEAD").and_return("12345")
      BellyPlatform::Identity.revision.should == '12345'

      BellyPlatform::Identity.should_not_receive(:`).with("git rev-parse HEAD")
      BellyPlatform::Identity.revision.should == '12345'
    end
  end

  context "#pid" do
    it "returns the process ID value" do
      Process.stub(:pid).and_return(112233)
      BellyPlatform::Identity.pid.should == 112233
    end
  end

  context "#platform_revision" do
    it "returns the current version of the platform gem" do
      BellyPlatform::Identity.platform_revision.should == BellyPlatform::VERSION
    end
  end
end