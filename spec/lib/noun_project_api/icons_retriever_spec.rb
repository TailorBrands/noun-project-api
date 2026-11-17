# frozen_string_literal: true

RSpec.describe NounProjectApi::IconsRetriever do
  subject(:retriever) { described_class.new(Faker::Internet.password(min_length: 16), Faker::Internet.password(min_length: 16)) }

  let(:base_url) { "#{NounProjectApi::API_BASE}#{described_class::API_PATH}" }

  describe "#recent_uploads" do
    let(:valid_hash) { JSON.parse(Fakes::Results::ICONS_RECENT_VALID) }
    let(:valid_response) { FakeResponse.new(body: Fakes::Results::ICONS_RECENT_VALID, code: "200") }

    before { allow(retriever.access_token).to receive(:get).and_return(valid_response) }

    it "returns the recent uploads" do
      results = retriever.recent_uploads

      expect(retriever.access_token).to have_received(:get).with("#{base_url}recent_uploads?")
      expect(results.size).to eq(valid_hash["recent_uploads"].size)
      expect(results).to all(be_a(NounProjectApi::Icon))
    end

    it "returns the recent uploads and passes limit when passed" do
      results = retriever.recent_uploads(3)

      expect(retriever.access_token).to have_received(:get).with("#{base_url}recent_uploads?limit=3")
      expect(results.size).to eq(3)
      expect(results).to all(be_a(NounProjectApi::Icon))
    end

    it "raises an error on a non 200 response" do
      allow(retriever.access_token).to receive(:get).and_return(FakeResponse.new(code: "404", body: "nope"))

      expect { retriever.recent_uploads }.to raise_error(NounProjectApi::ServiceError) { |error|
        expect(error.status).to eq("404")
        expect(error.body).to eq("nope")
      }
    end
  end

  describe "#find" do
    let(:valid_hash) { JSON.parse(Fakes::Results::ICONS_VALID) }
    let(:valid_response) { FakeResponse.new(body: Fakes::Results::ICONS_VALID, code: "200") }

    def search_url(term, query)
      "#{base_url}#{OAuth::Helper.escape(term)}?#{query}"
    end

    after do
      NounProjectApi.configuration.public_domain = false
      NounProjectApi.configuration.cache = ActiveSupport::Cache::NullStore.new
    end

    it "raises an error when no phrase is provided" do
      expect { retriever.find(nil) }.to raise_error(ArgumentError)
    end

    it "properly URI encodes search patterns" do
      allow(retriever.access_token).to receive(:get).and_return(valid_response)
      term = 'some search with ",] bad chars'

      results = retriever.find(term)

      expect(retriever.access_token).to have_received(:get).with(search_url(term, "limit_to_public_domain=0"))
      expect(results.size).to eq(valid_hash["icons"].size)
      expect(results).to all(be_a(NounProjectApi::Icon))
    end

    it "returns a proper result with a correct phrase" do
      allow(retriever.access_token).to receive(:get).and_return(valid_response)

      results = retriever.find("some search")

      expect(retriever.access_token).to have_received(:get).with(search_url("some search", "limit_to_public_domain=0"))
      expect(results.size).to eq(valid_hash["icons"].size)
      expect(results).to all(be_a(NounProjectApi::Icon))
    end

    it "properly handles public domain only config" do
      allow(retriever.access_token).to receive(:get).and_return(valid_response)
      NounProjectApi.configuration.public_domain = true

      results = retriever.find("some search")

      expect(retriever.access_token).to have_received(:get).with(search_url("some search", "limit_to_public_domain=1"))
      expect(results.size).to eq(valid_hash["icons"].size)
      expect(results).to all(be_a(NounProjectApi::Icon))
    end

    it "returns a proper result with a correct phrase and passes the args" do
      allow(retriever.access_token).to receive(:get).and_return(valid_response)

      results = retriever.find("some search", 4)

      expect(retriever.access_token).to have_received(:get)
        .with(search_url("some search", "limit=4&limit_to_public_domain=0"))
      expect(results.size).to eq(4)
      expect(results).to all(be_a(NounProjectApi::Icon))
    end

    it "passes limit, offset and page in sorted query order" do
      allow(retriever.access_token).to receive(:get).and_return(valid_response)

      retriever.find("cat", 15, 30, 2)

      expect(retriever.access_token).to have_received(:get)
        .with(search_url("cat", "limit=15&limit_to_public_domain=0&offset=30&page=2"))
    end

    it "returns an empty array for no result" do
      allow(retriever.access_token).to receive(:get).and_return(FakeResponse.new(code: "404"))

      expect(retriever.find("missing search")).to eq([])
    end

    it "raises an error on an unexpected response" do
      allow(retriever.access_token).to receive(:get).and_return(FakeResponse.new(code: "500", body: "boom"))

      expect { retriever.find("cat") }.to raise_error(NounProjectApi::ServiceError) { |error|
        expect(error.status).to eq("500")
        expect(error.body).to eq("boom")
      }
    end

    it "caches results under an MD5 key of the arguments with the configured TTL" do
      cache = ActiveSupport::Cache::MemoryStore.new
      NounProjectApi.configuration.cache = cache
      allow(cache).to receive(:fetch).and_call_original
      allow(retriever.access_token).to receive(:get).and_return(valid_response)

      first = retriever.find("cat", 15, nil, 2)
      second = retriever.find("cat", 15, nil, 2)

      expect(cache).to have_received(:fetch)
        .with(Digest::MD5.hexdigest("cat+15++2"), expires_in: 604_800).twice
      expect(retriever.access_token).to have_received(:get).once
      expect(second.map(&:original_hash)).to eq(first.map(&:original_hash))
    end
  end
end
