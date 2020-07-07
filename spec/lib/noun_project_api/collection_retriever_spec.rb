# frozen_string_literal: true

require "spec_helper"
require "ostruct"

RSpec.describe NounProjectApi::CollectionRetriever do
  before :each do
    @collection = NounProjectApi::CollectionRetriever.new(Faker::Internet.password(min_length: 16), Faker::Internet.password(min_length: 16))
    @valid_hash = JSON.parse(Fakes::Results::COLLECTION_VALID, symbolize_names: true)
    @valid_response = OpenStruct.new(
      body: Fakes::Results::COLLECTION_VALID,
      code: "200"
    )

    @missing_response = OpenStruct.new(
      code: "404"
    )
  end

  context "id" do
    it "raises an error when no id is provided" do
      expect { @collection.find(nil) }.to raise_error(ArgumentError)
    end

    it "returns a proper result with a correct id" do
      id = 1
      expect(@collection.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::CollectionRetriever::API_PATH}#{id}"
      ).and_return(
        @valid_response
      )

      result = @collection.find(id)
      expect(result).to be_a(NounProjectApi::Collection)
      expect(result.original_hash).to eq(@valid_hash[:collection])
    end

    it "raises an error with a missing id" do
      id = 1
      expect(@collection.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::CollectionRetriever::API_PATH}#{id}"
      ).and_return(
        @missing_response
      )

      expect { @collection.find(id) }.to raise_error(NounProjectApi::ServiceError)
    end
  end

  context "slug" do
    it "raises an error when no slug is provided" do
      expect { @collection.find_by_slug(nil) }.to raise_error(ArgumentError)
    end

    it "returns a proper result with a correct slug" do
      slug = "existing_slug"
      expect(@collection.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::CollectionRetriever::API_PATH}#{slug}"
      ).and_return(
        @valid_response
      )

      result = @collection.find(slug)
      expect(result).to be_a(NounProjectApi::Collection)
      expect(result.original_hash).to eq(@valid_hash[:collection])
    end

    it "raises an error with a missing slug" do
      slug = "missing_slug"
      expect(@collection.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::CollectionRetriever::API_PATH}#{slug}"
      ).and_return(
        @missing_response
      )

      expect { @collection.find_by_slug(slug) }.to raise_error(NounProjectApi::ServiceError)
    end
  end
end
