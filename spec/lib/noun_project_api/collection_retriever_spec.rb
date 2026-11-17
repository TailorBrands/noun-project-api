# frozen_string_literal: true

RSpec.describe NounProjectApi::CollectionRetriever do
  subject(:retriever) { described_class.new(Faker::Internet.password(min_length: 16), Faker::Internet.password(min_length: 16)) }

  let(:valid_hash) { JSON.parse(Fakes::Results::COLLECTION_VALID, symbolize_names: true) }
  let(:valid_response) { FakeResponse.new(body: Fakes::Results::COLLECTION_VALID, code: "200") }
  let(:missing_response) { FakeResponse.new(code: "404") }

  def url_for(id)
    "#{NounProjectApi::API_BASE}#{described_class::API_PATH}#{id}"
  end

  context "when finding by id" do
    it "raises an error when no id is provided" do
      expect { retriever.find(nil) }.to raise_error(ArgumentError)
    end

    it "returns a proper result with a correct id" do
      allow(retriever.access_token).to receive(:get).and_return(valid_response)

      result = retriever.find(1)

      expect(retriever.access_token).to have_received(:get).with(url_for(1))
      expect(result).to be_a(NounProjectApi::Collection)
      expect(result.original_hash).to eq(valid_hash[:collection])
    end

    it "raises an error with a missing id" do
      allow(retriever.access_token).to receive(:get).with(url_for(1)).and_return(missing_response)

      expect { retriever.find(1) }.to raise_error(NounProjectApi::ServiceError) { |error|
        expect(error.status).to eq("404")
        expect(error.message).to eq("Noun Project API Error")
      }
    end
  end

  context "when finding by slug" do
    it "raises an error when no slug is provided" do
      expect { retriever.find_by_slug(nil) }.to raise_error(ArgumentError)
    end

    it "returns a proper result with a correct slug" do
      allow(retriever.access_token).to receive(:get).and_return(valid_response)

      result = retriever.find_by_slug("existing_slug")

      expect(retriever.access_token).to have_received(:get).with(url_for("existing_slug"))
      expect(result).to be_a(NounProjectApi::Collection)
      expect(result.original_hash).to eq(valid_hash[:collection])
    end

    it "raises an error with a missing slug" do
      allow(retriever.access_token).to receive(:get).with(url_for("missing_slug")).and_return(missing_response)

      expect { retriever.find_by_slug("missing_slug") }.to raise_error(NounProjectApi::ServiceError)
    end
  end
end
