require 'spec_helper'
require 'ostruct'

RSpec.describe NounProjectApi::IconRetriever do
  it 'raises an error on empty initialization input' do
    expect { NounProjectApi::Icon.new }.to raise_error(ArgumentError)
  end

  it 'accepts JSON string input' do
    data = JSON.parse(Fakes::Results::ICON_VALID)
    expect { NounProjectApi::Icon.new(JSON.dump(data["icon"])) }.to_not raise_error
  end

  it 'accepts JSON string input with icon encapsulation' do
    expect { NounProjectApi::Icon.new(Fakes::Results::ICON_VALID) }.to_not raise_error
  end

  it 'accepts hash input' do
    data = JSON.parse(Fakes::Results::ICON_VALID)
    expect { NounProjectApi::Icon.new(data) }.to_not raise_error
  end

  context "exposed attributes" do
    before :each do
      @json = JSON.parse(Fakes::Results::ICON_VALID)
      @valid_icon = NounProjectApi::Icon.new(Fakes::Results::ICON_VALID)
    end

    it 'public domain' do
      expect(@valid_icon.public_domain?).to eq(@json["icon"]["license_description"] == "public-domain")
    end

    it 'SVG url' do
      expect(@valid_icon.svg_url).to eq(@json["icon"]["icon_url"])
    end

    it 'nil on missing SVG url' do
      @json["icon"].delete("icon_url")
      icon = NounProjectApi::Icon.new(@json)
      expect(icon.svg_url).to be_nil
    end

    it 'preview url defaults at 200 size' do
      expect(@valid_icon.preview_url).to eq(@json["icon"]["preview_url"])
    end

    it 'preview url for 200 size' do
      expect(@valid_icon.preview_url(NounProjectApi::Icon::PREVIEW_SIZE_200)).to eq(@json["icon"]["preview_url"])
    end

    it 'preview url for 84 size' do
      expect(@valid_icon.preview_url(NounProjectApi::Icon::PREVIEW_SIZE_84)).to eq(@json["icon"]["preview_url_84"])
    end

    it 'preview url for 42 size' do
      expect(@valid_icon.preview_url(NounProjectApi::Icon::PREVIEW_SIZE_42)).to eq(@json["icon"]["preview_url_42"])
    end

    it 'id as number' do
      expect(@valid_icon.id).to be_a(Fixnum)
      expect(@valid_icon.id).to eq(@json["icon"]["id"].to_i)
    end
  end
end
