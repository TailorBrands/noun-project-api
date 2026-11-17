# frozen_string_literal: true

RSpec.describe NounProjectApi::Reporter do
  it "raises an error when initialized without token" do
    expect { described_class.new(nil, Faker::Internet.password(min_length: 16)) }.to raise_error(ArgumentError)
  end

  it "raises an error when initialized without secret" do
    expect { described_class.new(Faker::Internet.password(min_length: 16), nil) }.to raise_error(ArgumentError)
  end

  it "initializes the values properly" do
    token = Faker::Internet.password(min_length: 16)
    secret = Faker::Internet.password(min_length: 16)
    reporter = described_class.new(token, secret)

    expect(reporter.token).to eq(token)
    expect(reporter.secret).to eq(secret)
  end

  describe "#report_used" do
    subject(:reporter) { described_class.new(Faker::Internet.password(min_length: 16), Faker::Internet.password(min_length: 16)) }

    let(:url) { "#{NounProjectApi::API_BASE}#{described_class::API_PATH}" }
    let(:headers) { { "Accept" => "application/json", "Content-Type" => "application/json" } }
    let(:valid_response) { FakeResponse.new(body: Fakes::Results::REPORTED_ONE, code: "200") }

    before { allow(reporter.access_token).to receive(:post).and_return(valid_response) }

    it "reports a singular id" do
      expect(reporter.report_used(122)).to be true
      expect(reporter.access_token).to have_received(:post).with(url, { icons: "122" }.to_json, headers)
    end

    it "reports a singular id for a string" do
      expect(reporter.report_used("122")).to be true
      expect(reporter.access_token).to have_received(:post).with(url, { icons: "122" }.to_json, headers)
    end

    it "reports multiple ids" do
      ids = [122, 4541, 34_211, 4352]

      expect(reporter.report_used(ids)).to be true
      expect(reporter.access_token).to have_received(:post).with(url, { icons: ids.join(",") }.to_json, headers)
    end

    it "returns false on a non 200 response" do
      allow(reporter.access_token).to receive(:post).and_return(FakeResponse.new(code: "500"))

      expect(reporter.report_used(122)).to be false
    end

    it "raises an error when no ids are given" do
      expect { reporter.report_used([]) }.to raise_error(ArgumentError)
      expect { reporter.report_used(nil) }.to raise_error(ArgumentError)
    end
  end
end
