# frozen_string_literal: true

RSpec.describe NounProjectApi::Collection do
  it "raises an error on empty initialization input" do
    expect { described_class.new }.to raise_error(ArgumentError)
  end

  it "accepts JSON string input" do
    data = JSON.parse(Fakes::Results::COLLECTION_VALID)
    expect { described_class.new(JSON.dump(data["collection"])) }.not_to raise_error
  end

  it "accepts JSON string input with collection encapsulation" do
    expect { described_class.new(Fakes::Results::COLLECTION_VALID) }.not_to raise_error
  end

  it "accepts hash input" do
    data = JSON.parse(Fakes::Results::COLLECTION_VALID)
    expect { described_class.new(data) }.not_to raise_error
  end

  describe "exposed attributes" do
    subject(:collection) { described_class.new(Fakes::Results::COLLECTION_VALID) }

    let(:json) { JSON.parse(Fakes::Results::COLLECTION_VALID) }

    it "id as number" do
      expect(collection.id).to be_a(Integer)
      expect(collection.id).to eq(json["collection"]["id"].to_i)
    end

    it "author id as number" do
      expect(collection.author_id).to eq(json["collection"]["author_id"].to_i)
    end

    it "author name" do
      expect(collection.author_name).to eq(json["collection"]["author"]["name"])
    end

    it "icon count as number" do
      expect(collection.icon_count).to eq(json["collection"]["icon_count"].to_i)
    end

    it "is published" do
      expect(collection.published?).to eq(json["collection"]["is_published"].to_i == 1)
    end

    it "builds a simple hash" do
      expect(collection.to_hash).to eq(
        id: collection.id,
        author_id: collection.author_id,
        author_name: collection.author_name,
        icon_count: collection.icon_count,
        published: collection.published?
      )
    end

    it "json formats the hash" do
      expect(collection.to_json).to eq JSON.dump collection.to_hash
    end
  end
end
