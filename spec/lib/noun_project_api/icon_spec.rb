# frozen_string_literal: true

RSpec.describe NounProjectApi::Icon do
  it "raises an error on empty initialization input" do
    expect { described_class.new }.to raise_error(ArgumentError)
  end

  it "accepts JSON string input" do
    data = JSON.parse(Fakes::Results::ICON_VALID)
    expect { described_class.new(JSON.dump(data["icon"])) }.not_to raise_error
  end

  it "accepts JSON string input with icon encapsulation" do
    expect { described_class.new(Fakes::Results::ICON_VALID) }.not_to raise_error
  end

  it "accepts hash input" do
    data = JSON.parse(Fakes::Results::ICON_VALID)
    expect { described_class.new(data) }.not_to raise_error
  end

  describe "exposed attributes" do
    subject(:icon) { described_class.new(Fakes::Results::ICON_VALID) }

    let(:json) { JSON.parse(Fakes::Results::ICON_VALID) }

    it "public domain" do
      expect(icon.public_domain?).to eq(json["icon"]["license_description"] == "public-domain")
    end

    it "SVG url" do
      expect(icon.svg_url).to eq(json["icon"]["icon_url"])
    end

    it "nil on missing SVG url" do
      json["icon"].delete("icon_url")
      expect(described_class.new(json).svg_url).to be_nil
    end

    it "preview url defaults at 200 size" do
      expect(icon.preview_url).to eq(json["icon"]["preview_url"])
    end

    it "preview url for 200 size" do
      expect(icon.preview_url(described_class::PREVIEW_SIZE_200)).to eq(json["icon"]["preview_url"])
    end

    it "preview url for 84 size" do
      expect(icon.preview_url(described_class::PREVIEW_SIZE_84)).to eq(json["icon"]["preview_url_84"])
    end

    it "preview url for 42 size" do
      expect(icon.preview_url(described_class::PREVIEW_SIZE_42)).to eq(json["icon"]["preview_url_42"])
    end

    it "id as number" do
      expect(icon.id).to be_a(Integer)
      expect(icon.id).to eq(json["icon"]["id"].to_i)
    end

    it "builds a simple hash" do
      expect(icon.to_hash).to eq(
        id: icon.id,
        preview_url_200: icon.preview_url(described_class::PREVIEW_SIZE_200),
        preview_url_84: icon.preview_url(described_class::PREVIEW_SIZE_84),
        preview_url_42: icon.preview_url(described_class::PREVIEW_SIZE_42)
      )
    end

    it "json formats the hash" do
      expect(icon.to_json).to eq JSON.dump icon.to_hash
    end

    it "round-trips through Marshal, as Rails.cache stores it" do
      restored = Marshal.load(Marshal.dump(icon))
      expect(restored.original_hash).to eq(icon.original_hash)
      expect(restored.instance_variables).to eq([:@original_hash])
    end
  end
end
