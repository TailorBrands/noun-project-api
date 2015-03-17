require 'spec_helper'

RSpec.describe NounProjectApi::Reporter do
  it 'raises an error when initialized without token' do
    expect { NounProjectApi::Reporter.new(nil, Faker::Internet.password(16)) }.to raise_error(ArgumentError)
  end

  it 'raises an error when initialized without secret' do
    expect { NounProjectApi::Reporter.new(Faker::Internet.password(16), nil) }.to raise_error(ArgumentError)
  end

  it 'initializes the values properly' do
    token = Faker::Internet.password(16)
    secret = Faker::Internet.password(16)
    retriever = NounProjectApi::Reporter.new(token, secret)

    expect(retriever.token).to eq(token)
    expect(retriever.secret).to eq(secret)
  end
end
