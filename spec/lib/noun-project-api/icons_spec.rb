require 'spec_helper'

RSpec.describe NounProjectApi::Icons do
  before :each do
    @icons = NounProjectApi::Icons.new(Faker::Internet.password(16), Faker::Internet.password(16))
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
        "#{NounProjectApi::API_BASE}#{NounProjectApi::Icons::API_PATH}recent_uploads"
      ).and_return(
        valid_response
      )

      expect(@icons.recent_uploads).to eq(valid_hash["recent_uploads"])
    end

    it "returns the recent uploads and passes limit when passed" do
      valid_hash = JSON.parse(Fakes::Results::ICONS_RECENT_VALID)
      valid_response = OpenStruct.new(
        body: Fakes::Results::ICONS_RECENT_VALID,
        code: '200'
      )

      limit = 10

      expect(@icons.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::Icons::API_PATH}recent_uploads?limit=#{limit}&"
      ).and_return(
        valid_response
      )

      expect(@icons.recent_uploads(limit)).to eq(valid_hash["recent_uploads"])
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
        "#{NounProjectApi::API_BASE}#{NounProjectApi::Icons::API_PATH}#{URI::encode(term)}"
      ).and_return(
        valid_response
      )

      expect(@icons.find(term)).to eq(valid_hash["icons"])
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
        "#{NounProjectApi::API_BASE}#{NounProjectApi::Icons::API_PATH}#{URI::encode(term)}"
      ).and_return(
        valid_response
      )

      expect(@icons.find(term)).to eq(valid_hash["icons"])
    end

    it 'returns a proper result with a correct phrase and passes along the args' do
      valid_hash = JSON.parse(Fakes::Results::ICONS_VALID)
      valid_response = OpenStruct.new(
        body: Fakes::Results::ICONS_VALID,
        code: '200'
      )

      term = 'some search'
      limit = 10
      expect(@icons.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::Icons::API_PATH}#{URI::encode(term)}?limit=#{limit}&"
      ).and_return(
        valid_response
      )

      expect(@icons.find(term, limit)).to eq(valid_hash["icons"])
    end

    it 'returns an empty array for no result' do
      missing_response = OpenStruct.new(
        code: '404'
      )

      term = 'missing search'
      expect(@icons.access_token).to receive(
        :get
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::Icons::API_PATH}#{URI::encode(term)}"
      ).and_return(
        missing_response
      )

      expect(@icons.find(term)).to eq([])
    end
  end
end
