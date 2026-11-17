# frozen_string_literal: true

# Exercises oauth's own AccessToken#request (including its same-origin check)
# by stubbing only the consumer's transport, not the access token.
RSpec.describe NounProjectApi::Connection do
  let(:token) { Faker::Internet.password(min_length: 16) }
  let(:secret) { Faker::Internet.password(min_length: 16) }
  let(:ok) { FakeResponse.new(code: "200", body: Fakes::Results::ICON_VALID) }

  def stub_transport(client, response)
    allow(client.access_token.consumer).to receive(:request).and_return(response)
  end

  it "configures the OAuth consumer site as the API origin" do
    client = NounProjectApi::IconRetriever.new(token, secret)

    expect(client.access_token.consumer.site).to eq(NounProjectApi::API_BASE)
  end

  it "allows signed GET requests to the API" do
    client = NounProjectApi::IconRetriever.new(token, secret)
    stub_transport(client, ok)

    expect(client.find(1)).to be_a(NounProjectApi::Icon)
    expect(client.access_token.consumer).to have_received(:request)
      .with(:get, "#{NounProjectApi::API_BASE}/icon/1", client.access_token, {}, {})
  end

  it "allows signed search requests to the API" do
    client = NounProjectApi::IconsRetriever.new(token, secret)
    stub_transport(client, FakeResponse.new(code: "200", body: Fakes::Results::ICONS_VALID))

    expect(client.find("cat")).to all(be_a(NounProjectApi::Icon))
  end

  it "allows signed POST requests to the API" do
    client = NounProjectApi::Reporter.new(token, secret)
    stub_transport(client, FakeResponse.new(code: "200", body: Fakes::Results::REPORTED_ONE))

    expect(client.report_used(1)).to be true
  end
end
