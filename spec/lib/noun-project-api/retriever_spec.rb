require "spec_helper"

RSpec.describe NounProjectApi::Retriever do
  it "raises an error when initialized without token" do
    expect { NounProjectApi::Retriever.new(nil, Faker::Internet.password(min_length: 16)) }.to raise_error(ArgumentError)
  end

  it "raises an error when initialized without secret" do
    expect { NounProjectApi::Retriever.new(Faker::Internet.password(min_length: 16), nil) }.to raise_error(ArgumentError)
  end

  it "initializes the values properly" do
    token = Faker::Internet.password(min_length: 16)
    secret = Faker::Internet.password(min_length: 16)
    retriever = NounProjectApi::Retriever.new(token, secret)

    expect(retriever.token).to eq(token)
    expect(retriever.secret).to eq(secret)
  end
end
