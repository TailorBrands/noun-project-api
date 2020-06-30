# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe NounProjectApi::BaseItem do
  it 'raises an error on direct initialization' do
    data = JSON.parse(Fakes::Results::ICON_VALID)
    expect do
      NounProjectApi::BaseItem.new(JSON.dump(data['icon']))
    end.to raise_error(NotImplementedError)
  end
end
