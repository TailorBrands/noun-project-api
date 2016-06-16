require "spec_helper"

RSpec.describe NounProjectApi do
  it "has the correct default" do
    expect(NounProjectApi.configuration.public_domain).to be false
  end

  it "sets the correct configuration" do
    expect(NounProjectApi.configuration.public_domain).to be false

    NounProjectApi.configure do |config|
      config.public_domain = true
    end

    expect(NounProjectApi.configuration.public_domain).to be true

    NounProjectApi.configuration.public_domain = false
  end
end
