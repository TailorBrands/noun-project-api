require "spec_helper"
require "ostruct"

RSpec.describe NounProjectApi::IconRetriever do
  before :each do
    @icon = NounProjectApi::IconRetriever.new(Faker::Internet.password(16), Faker::Internet.password(16))
    @valid_hash = JSON.parse(Fakes::Results::ICON_VALID)
    @valid_response = OpenStruct.new(
      body: Fakes::Results::ICON_VALID,
      code: "200"
    )

    @missing_response = OpenStruct.new(
      code: "404"
    )
  end

  context "id" do
    it "raises an error when no id is provided" do
      expect { @icon.find(nil) }.to raise_error(ArgumentError)
    end

    it "returns a proper result with a correct id" do
      id = 1
      expect(@icon.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::IconRetriever::API_PATH}#{id}"
      ).and_return(
        @valid_response
      )

      result = @icon.find(id)
      expect(result).to be_a(NounProjectApi::Icon)
      expect(result.original_hash).to eq(@valid_hash["icon"])
    end

    it "raises an error with a missing id" do
      id = 1
      expect(@icon.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::IconRetriever::API_PATH}#{id}"
      ).and_return(
        @missing_response
      )

      expect { @icon.find(id) }.to raise_error(ArgumentError)
    end
  end

  context "slug" do
    it "raises an error when no slug is provided" do
      expect { @icon.find_by_slug(nil) }.to raise_error(ArgumentError)
    end

    it "returns a proper result with a correct slug" do
      slug = "existing_slug"
      expect(@icon.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::IconRetriever::API_PATH}#{slug}"
      ).and_return(
        @valid_response
      )

      result = @icon.find(slug)
      expect(result).to be_a(NounProjectApi::Icon)
      expect(result.original_hash).to eq(@valid_hash["icon"])
    end

    it "raises an error with a missing slug" do
      slug = "missing_slug"
      expect(@icon.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::IconRetriever::API_PATH}#{slug}"
      ).and_return(
        @missing_response
      )

      expect { @icon.find_by_slug(slug) }.to raise_error(ArgumentError)
    end
  end
end
