# frozen_string_literal: true

RSpec.describe NounProjectApi do
  after { described_class.configuration.public_domain = false }

  it "has the correct default" do
    expect(described_class.configuration.public_domain).to be false
  end

  it "defaults to a null cache store with a one week TTL" do
    expect(described_class.configuration.cache).to be_a(ActiveSupport::Cache::NullStore)
    expect(described_class.configuration.cache_ttl).to eq(604_800)
  end

  it "sets the correct configuration" do
    expect(described_class.configuration.public_domain).to be false

    described_class.configure do |config|
      config.public_domain = true
    end

    expect(described_class.configuration.public_domain).to be true
  end

  it "exposes the gem version" do
    expect(described_class::VERSION).to eq("5.0.1")
  end
end
