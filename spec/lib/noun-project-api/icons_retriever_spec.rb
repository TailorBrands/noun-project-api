require 'spec_helper'

RSpec.describe NounProjectApi::IconsRetriever do
  before :each do
    @icons = NounProjectApi::IconsRetriever.new(Faker::Internet.password(16), Faker::Internet.password(16))
  end

  context "recent uploads" do
    it "returns the recent uploads" do
      valid_hash = JSON.parse(Fakes::Results::ICONS_RECENT_VALID)
      valid_response = OpenStruct.new(
        body: Fakes::Results::ICONS_RECENT_VALID,
        code: '200'
      )

      expect(@icons.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::IconsRetriever::API_PATH}recent_uploads"
      ).and_return(
        valid_response
      )

      results = @icons.recent_uploads
      expect(results.size).to eq(valid_hash["recent_uploads"].size)
      results.each do |icon|
        expect(icon).to be_a(NounProjectApi::Icon)
      end
    end

    it "returns the recent uploads and passes limit when passed" do
      valid_response = OpenStruct.new(
        body: Fakes::Results::ICONS_RECENT_VALID,
        code: '200'
      )

      limit = 3

      expect(@icons.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::IconsRetriever::API_PATH}recent_uploads?limit=#{limit}&"
      ).and_return(
        valid_response
      )

      results = @icons.recent_uploads(limit)
      expect(results.size).to eq(limit)
      results.each do |icon|
        expect(icon).to be_a(NounProjectApi::Icon)
      end
    end
  end

  context "Icons search" do
    it 'raises an error when no phrase is provided' do
      expect { @icons.find(nil) }.to raise_error(ArgumentError)
    end

    it 'properly URI encodes search patterns' do
      valid_hash = JSON.parse(Fakes::Results::ICONS_VALID)
      valid_response = OpenStruct.new(
        body: Fakes::Results::ICONS_VALID,
        code: '200'
      )

      term = 'some search'
      expect(@icons.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::IconsRetriever::API_PATH}#{URI::encode(term)}?limit_to_public_domain=0"
      ).and_return(
        valid_response
      )

      results = @icons.find(term)
      expect(results.size).to eq(valid_hash["icons"].size)
      results.each do |icon|
        expect(icon).to be_a(NounProjectApi::Icon)
      end
    end

    it 'returns a proper result with a correct phrase' do
      valid_hash = JSON.parse(Fakes::Results::ICONS_VALID)
      valid_response = OpenStruct.new(
        body: Fakes::Results::ICONS_VALID,
        code: '200'
      )

      term = 'some search'
      expect(@icons.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::IconsRetriever::API_PATH}#{URI::encode(term)}?limit_to_public_domain=0"
      ).and_return(
        valid_response
      )

      results = @icons.find(term)
      expect(results.size).to eq(valid_hash["icons"].size)
      results.each do |icon|
        expect(icon).to be_a(NounProjectApi::Icon)
      end
    end

    it 'returns a proper result with a correct phrase and passes along the args' do
      valid_response = OpenStruct.new(
        body: Fakes::Results::ICONS_VALID,
        code: '200'
      )

      term = 'some search'
      limit = 4
      expect(@icons.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::IconsRetriever::API_PATH}#{URI::encode(term)}?limit_to_public_domain=0&limit=#{limit}"
      ).and_return(
        valid_response
      )

      results = @icons.find(term, limit)
      expect(results.size).to eq(limit)
      results.each do |icon|
        expect(icon).to be_a(NounProjectApi::Icon)
      end
    end

    it 'returns an empty array for no result' do
      missing_response = OpenStruct.new(
        code: '404'
      )

      term = 'missing search'
      expect(@icons.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::IconsRetriever::API_PATH}#{URI::encode(term)}?limit_to_public_domain=0"
      ).and_return(
        missing_response
      )

      results = @icons.find(term)
      expect(results.size).to eq(0)
    end
  end
end
