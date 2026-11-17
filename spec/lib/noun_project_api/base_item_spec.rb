# frozen_string_literal: true

RSpec.describe NounProjectApi::BaseItem do
  it "raises an error on direct initialization" do
    data = JSON.parse(Fakes::Results::ICON_VALID)
    expect {
      described_class.new(JSON.dump(data["icon"]))
    }.to raise_error(NotImplementedError)
  end
end
