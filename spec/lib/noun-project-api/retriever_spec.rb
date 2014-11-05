require 'spec_helper'

RSpec.describe NounProjectApi::Retriever do
  context "Bad initialization" do
    it 'raises an error when initialized without token'
    it 'raises an error when initialized without secret'
  end

  context "Icons" do
    it 'raises an error when no phrase is provided'
    it 'returns a proper result with a correct phrase'
    it 'returns an empty result with a missing phrase'
  end

  context "Icon" do
    it 'raises an error when no id is provided'
    it 'returns a proper result with a correct id'
    it 'returns an empty result with a missing id'
  end
end
