# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe NounProjectApi::CollectionRetriever do
  it 'raises an error on empty initialization input' do
    expect { NounProjectApi::Collection.new }.to raise_error(ArgumentError)
  end

  it 'accepts JSON string input' do
    data = JSON.parse(Fakes::Results::COLLECTION_VALID)
    expect { NounProjectApi::Collection.new(JSON.dump(data['collection'])) }.to_not raise_error
  end

  it 'accepts JSON string input with collection encapsulation' do
    expect { NounProjectApi::Collection.new(Fakes::Results::COLLECTION_VALID) }.to_not raise_error
  end

  it 'accepts hash input' do
    data = JSON.parse(Fakes::Results::COLLECTION_VALID)
    expect { NounProjectApi::Collection.new(data) }.to_not raise_error
  end

  context 'exposed attributes' do
    before :each do
      @json = JSON.parse(Fakes::Results::COLLECTION_VALID)
      @valid_collection = NounProjectApi::Collection.new(Fakes::Results::COLLECTION_VALID)
    end

    it 'id as number' do
      expect(@valid_collection.id).to be_a(Integer)
      expect(@valid_collection.id).to eq(@json['collection']['id'].to_i)
    end

    it 'author id as number' do
      expect(@valid_collection.author_id).to eq(@json['collection']['author_id'].to_i)
    end

    it 'author name' do
      expect(@valid_collection.author_name).to eq(@json['collection']['author']['name'])
    end

    it 'icon count as number' do
      expect(@valid_collection.icon_count).to eq(@json['collection']['icon_count'].to_i)
    end

    it 'is published' do
      expect(@valid_collection.published?).to eq(@json['collection']['is_published'].to_i == 1)
    end

    it 'builds a simple hash' do
      expect(@valid_collection.to_hash).to eq({
                                                id: @valid_collection.id,
                                                author_id: @valid_collection.author_id,
                                                author_name: @valid_collection.author_name,
                                                icon_count: @valid_collection.icon_count,
                                                published: @valid_collection.published?
                                              })
    end

    it 'json formats the hash' do
      expect(@valid_collection.to_json).to eq JSON.dump @valid_collection.to_hash
    end
  end
end
